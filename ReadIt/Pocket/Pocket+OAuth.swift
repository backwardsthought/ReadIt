//
// Created by Felipe Lobo on 2018-09-29.
// Copyright (c) 2018 Copyisright. All rights reserved.
//

import Foundation

extension Pocket {

	struct OAuth {
		var code: String
		var accessToken: String

		func authorizeURL() throws -> URL {
			OAuth.authorizeURL(code: code)
		}

		func authenticateURL() throws -> URL {
			OAuth.authenticateURL(code: code)
		}
	}

}

extension Pocket.OAuth {

	static var requestURL: URL = {
		var components = URLComponents()
		components.scheme = "https"
		components.host = "getpocket.com"
		components.path = "/v3/oauth/request"

		let key = URLQueryItem(name: "consumer_key", value: Pocket.consumerKey)
		let redirect = URLQueryItem(name: "redirect_uri", value: Pocket.redirectUri)

		components.queryItems = [key, redirect]

		guard let url = components.url else {
			fatalError("It should always exist, since the components are statically instantiated")
		}

		return url
	}()

	static func authorizeURL(code: String) -> URL {
		var components = URLComponents()
		components.scheme = "https"
		components.host = "getpocket.com"
		components.path = "/v3/oauth/authorize"

		let key = URLQueryItem(name: "consumer_key", value: Pocket.consumerKey)
		let redirect = URLQueryItem(name: "code", value: code)

		components.queryItems = [key, redirect]

		guard let url = components.url else {
			fatalError("It should always exist, since the components are statically instantiated")
		}

		return url
	}

	static func authenticateURL(code: String) -> URL {
		var components = URLComponents()
		components.scheme = "https"
		components.host = "getpocket.com"
		components.path = "/auth/authorize"

		let token = URLQueryItem(name: "request_token", value: code)
		let uri = URLQueryItem(name: "redirect_uri", value: Pocket.redirectUri)

		components.queryItems = [token, uri]

		guard let url = components.url else {
			fatalError("It should always exist, since the components are statically instantiated")
		}

		return url
	}

}

extension Pocket.OAuth: Authorization { }
