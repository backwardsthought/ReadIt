//  
//  PocketAuthService.swift
//  ReadIt
//
//  Created by Felipe Lobo on 13/05/21.
//  Copyright (c) 2021 Copyisright. All rights reserved.
//

import Foundation
import AuthenticationServices
import Combine

class PocketAuthService {

	var network: NetworkSession
	var presentationContextProvider: ASWebAuthenticationPresentationContextProviding

	init(network: NetworkSession, presentationContextProvider: ASWebAuthenticationPresentationContextProviding) {
		self.network = network
		self.presentationContextProvider = presentationContextProvider
	}

	func login() -> AnyPublisher<Pocket.OAuth, Error> {
		requestToken()
 	 		.flatMap { [unowned self] code in
				promptUser(code: code)
			}
			.flatMap { [unowned self] code in
				authorize(code: code).map { Pocket.OAuth(code: code, accessToken: $0) }
			}
			.eraseToAnyPublisher()
	}

	private func requestToken() -> AnyPublisher<String, Error> {
		network.session
			.dataTaskPublisher(for: Pocket.OAuth.requestURL)
			.map(\.data)
			.map { data in
				let rawString = String(data: data, encoding: .utf8)!
				return rawString.replacingOccurrences(of: "code=", with: "")
			}
			.mapError { $0 as Error }
			.eraseToAnyPublisher()
	}

	private func promptUser(code: String) -> AnyPublisher<String, Error> {
		Future<String, Error> { [presentationContextProvider] promise in
			let url = Pocket.OAuth.authenticateURL(code: code)
			let session = ASWebAuthenticationSession(url: url, callbackURLScheme: Pocket.redirectUri) { url, error in
				promise(.success(code))
//				if let _ = url {
//					promise(.success(code))
//				} else if let error = error {
//					promise(.failure(error))
//				}
			}
			session.presentationContextProvider = presentationContextProvider
			session.start()
		}.eraseToAnyPublisher()
	}

	private func authorize(code: String) -> AnyPublisher<String, Error> {
		network.session
			.dataTaskPublisher(for: Pocket.OAuth.authorizeURL(code: code))
			.map(\.data)
			.map { data -> String in
				let rawBody = String(data: data, encoding: .utf8)!
				let bodyParts = rawBody.split(separator: "&")
					.map { substring -> String in
						let equal = substring.range(of: "=")!
						return String(substring.suffix(from: equal.upperBound))
					}
				guard let authorization = bodyParts.first else {
					return "" // FIXME
				}
				return authorization
			}
			.mapError { $0 as Error }
			.eraseToAnyPublisher()
	}

}
