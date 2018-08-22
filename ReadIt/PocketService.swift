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
		let url = URL(string: "https://getpocket.com")!
		return url
	}

	public var path: String {
		if case .get = self {
			return "/v3/get"
		}

		return ""
	}

	public var method: Moya.Method {
		return .get
	}

	public var sampleData: Data {
		return Data()
	}

	public var task: Task {
		return .requestPlain
	}

	public var headers: [String: String]? {
		return []
	}

}