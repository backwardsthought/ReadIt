//
// Created by Felipe Lobo on 22/08/18.
// Copyright (c) 2018 Copyisright. All rights reserved.
//

import Moya

enum PocketService {
	case get
}

extension PocketService: TargetType {

	public var baseURL: URL {
		let url = URL(string: Pocket.host)!
		return url
	}

	public var path: String {
		return "/v3/get"
	}

	public var method: Moya.Method {
		return .get
	}

	public var sampleData: Data {
		return Data()
	}

	public var task: Task {
		return .requestParameters(parameters: ["detailType": "complete"], encoding: URLEncoding.default)
	}

	public var headers: [String: String]? {
        return [:]
	}

}
