//
// Created by Felipe Lobo on 2018-09-29.
// Copyright (c) 2018 Copyisright. All rights reserved.
//

import Foundation

class OAuth {

	enum Error: Swift.Error {
		case nilCode
		case nilAccessToken
	}

	var code: String?
	var accessToken: String?

	static var requestURL: URL {
		var components = URLComponents()
		components.scheme = "https"
		components.host = "getpocket.com"
		components.path = "/v3/oauth/request"

		let key = URLQueryItem(name: "consumer_key", value: Pocket.consumerKey)
		let redirect = URLQueryItem(name: "redirect_uri", value: Pocket.redirectUri)

		components.queryItems = [key, redirect]

		guard let url = components.url else {
			fatalError("How the fuck can it not exist, if it is all static?")
		}

		return url
	}

	func authorizeURL() throws -> URL {
		guard let code = code else {
			throw Error.nilCode
		}

		var components = URLComponents()
		components.scheme = "https"
		components.host = "getpocket.com"
		components.path = "/v3/oauth/authorize"

		let key = URLQueryItem(name: "consumer_key", value: Pocket.consumerKey)
		let redirect = URLQueryItem(name: "code", value: code)

		components.queryItems = [key, redirect]

		guard let url = components.url else {
			fatalError("How the fuck can it not exist, if it is all static?")
		}

		return url
	}

	func authenticateURL() throws -> URL {
		guard let code = code else {
			throw Error.nilCode
		}

		var components = URLComponents()
		components.scheme = "https"
		components.host = "getpocket.com"
		components.path = "/auth/authorize"

		let token = URLQueryItem(name: "request_token", value: code)
		let uri = URLQueryItem(name: "redirect_uri", value: Pocket.redirectUri)

		components.queryItems = [token, uri]

		guard let url = components.url else {
			fatalError("How the fuck can it not exist, if it is all static?")
		}

		return url
	}

}
