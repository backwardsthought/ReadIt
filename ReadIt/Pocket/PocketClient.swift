//
// Created by Felipe Lobo on 23/08/18.
// Copyright (c) 2018 Copyisright. All rights reserved.
//

import Alamofire
import Moya
import RxSwift
import AuthenticationServices

class PocketClient {

	private let disposeBag = DisposeBag()

	private var authSession: ASWebAuthenticationSession?
	private var credentials = OAuth()
    
    var contextProvider: ASWebAuthenticationPresentationContextProviding
    
    init(contextProvider: ASWebAuthenticationPresentationContextProviding) {
        self.contextProvider = contextProvider
    }

	func create() -> MoyaProvider<PocketService> {
		if let accessToken = credentials.accessToken {
			let endpointClosure = { (target: PocketService) -> Endpoint in
				var authParameters = ["consumer_key": Pocket.consumerKey, "access_token": accessToken]
                
                if case .requestParameters(let unwrappedParams, _) = target.task,
                    let params = unwrappedParams as? [String: String] {
                    authParameters.merge(params) { _, target in target }
                }

				return Endpoint(
						url: URL(target: target).absoluteString,
						sampleResponseClosure: { .networkResponse(200, target.sampleData) },
						method: target.method,
						task: .requestParameters(parameters: authParameters, encoding: URLEncoding.default),
						httpHeaderFields: target.headers
				)
			}

			return MoyaProvider<PocketService>(endpointClosure: endpointClosure, plugins: [NetworkLoggerPlugin()])
		}

		return MoyaProvider<PocketService>()
	}

	func login() -> Completable {
		return requestToken()
                .do(onSuccess: updateCode(code:))
                .asCompletable()
                .andThen(promptUser())
				.andThen(authorize())
				.do (onSuccess: updateAccessToken(accessToken:))
                .asCompletable()
	}
    
    // MARK: - Requests

	private func requestToken() -> Single<String> {
		return Single.create { observer in
			let url = OAuth.requestURL
			let dataRequest = Alamofire.request(url)
					.validate()
					.response { response in
						guard let data = response.data else {
							if let error = response.error {
								observer(.error(error))
							}
							return // TODO proper error handling
						}

						let rawResponse = String(data: data, encoding: .utf8)!
						let code = rawResponse.replacingOccurrences(of: "code=", with: "")

						observer(.success(code))
					}

			return Disposables.create {
				dataRequest.cancel()
			}
		}
	}

	private func promptUser() -> Completable {
        let credentials = self.credentials
		return Completable.create { [weak self] observer in
            do {
                let url = try credentials.authenticateURL()
                let session = ASWebAuthenticationSession(url: url, callbackURLScheme: Pocket.redirectUri) { url, error in
                    if let _ = url {
                        observer(.completed)
                    } else if let error = error {
                        observer(.error(error))
                    }
                }
                
                session.presentationContextProvider = self?.contextProvider
                session.start()
                
                self?.authSession = session
            } catch {
                observer(.error(error))
            }

			return Disposables.create {
				self?.authSession = nil
			}
		}
	}

	private func authorize() -> Single<String> {
		let credentials = self.credentials
		var dataRequest: DataRequest?

		return Single.create { observer in
			do {
				let url = try credentials.authorizeURL()
				dataRequest = Alamofire.request(url)
						.validate()
						.response { response in
							guard let data = response.data else {
								if let error = response.error {
									observer(.error(error))
								}
								return // TODO proper error handling
							}

							let rawBody = String(data: data, encoding: .utf8)!

							let bodyParts = rawBody.split(separator: "&")
									.map { substring -> String in
										let equal = substring.range(of: "=")!
										return String(substring.suffix(from: equal.upperBound))
									}

							guard let authorization = bodyParts.first else {
								return // TODO proper error handling
							}

							observer(.success(authorization))
						}
			} catch {
				observer(.error(error))
			}

			return Disposables.create {
				dataRequest?.cancel()
			}
		}
	}
    
    // MARK: - Credentials updating
    
    func updateCode(code: String) {
        credentials.code = code
    }
    
    func updateAccessToken(accessToken: String) {
        credentials.accessToken = accessToken
    }

}
