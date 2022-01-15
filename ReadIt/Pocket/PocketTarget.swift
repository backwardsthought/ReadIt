//
// Created by Felipe Lobo on 22/08/18.
// Copyright (c) 2018 Copyisright. All rights reserved.
//

enum PocketTarget {
	case get
}

extension PocketTarget: Target {

	var host: String {
		Pocket.host
	}

	var path: String {
		"/v3/get"
	}

	var parameters: [String: Any]? {
		["detailType": "complete"]
	}

}
