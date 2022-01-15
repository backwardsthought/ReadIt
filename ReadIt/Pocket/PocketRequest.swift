//  
//  PocketRequestProvider.swift
//  ReadIt
//
//  Created by Felipe Lobo on 14/05/21.
//  Copyright (c) 2021 Copyisright. All rights reserved.
//

import Foundation
import Combine

struct PocketRequest {

	let network: NetworkSession
	let authorization: Authorization

}

extension PocketRequest: RequestProvider {

	func request(_ target: PocketTarget) -> AnyPublisher<[Pocket], Error> {
		self.request(target, decodedType: Pocket.RequestResult.self)
			.map { $0.getValues() }
			.eraseToAnyPublisher()
	}
	
	func request<R: Decodable, T: Target>(_ target: T, decodedType: R.Type) -> AnyPublisher<R, Error> {
		Deferred<Just<URLRequest>> { [authorization] in
			var requestURLComponents = target.requestComponents()
			requestURLComponents.queryItems = [
				URLQueryItem(name: "consumer_key", value: Pocket.consumerKey),
				URLQueryItem(name: "access_token", value: authorization.accessToken),
				URLQueryItem(name: "detailType", value: "complete")
			]

			var request = URLRequest(url: requestURLComponents.url!) // FIXME: Throw a specific error
			request.httpMethod = target.method.rawValue

			return Just(request)
		}.flatMap { [network] request in
			network.session
				.dataTaskPublisher(for: request)
				.map(\.data)
				.decode(type: decodedType, decoder: JSONDecoder())
		}.eraseToAnyPublisher()
	}

}
