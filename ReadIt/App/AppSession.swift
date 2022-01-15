//
// Created by Felipe Lobo on 22/08/18.
// Copyright (c) 2018 Copyisright. All rights reserved.
//

import Foundation

class AppSession {

	let network: Network
	private(set) var authorizations: [Service: Authorization] = [:]

	init() {
		network = Network()
	}

	func add(authorization: Authorization, for service: Service) {
		authorizations[service] = authorization
	}

}

extension AppSession {

	class Network: NetworkSession {
		let session: URLSession

		init() {
			let sessionConfig = URLSessionConfiguration.default
			session = URLSession(configuration: sessionConfig)
		}
	}

}
