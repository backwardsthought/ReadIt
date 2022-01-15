//  
//  Target.swift
//  ReadIt
//
//  Created by Felipe Lobo on 13/05/21.
//  Copyright (c) 2021 Copyisright. All rights reserved.
//

import Foundation

enum Method: String {
	case get = "GET"
	case post = "POST"
	case put = "PUT"
}

enum TargetError: Error {
	case malformedURL
}

protocol Target {

	var host: String { get }
	var scheme: String { get }
	var path: String { get }
	var method: Method { get }
	var parameters: [String: Any]? { get }

	func requestComponents() -> URLComponents

}

extension Target {

	var scheme: String {
		"https"
	}

	var parameters: [String: Any]? {
		nil
	}

	var method: Method {
		.get
	}

	func requestComponents() -> URLComponents {
		var urlComponents = URLComponents()
		urlComponents.host = host
		urlComponents.scheme = scheme
		urlComponents.path = path

		return urlComponents
	}

}

