//
// Created by Felipe Lobo on 23/08/18.
// Copyright (c) 2018 Copyisright. All rights reserved.
//

import Moya

struct Client {

	func create<T: TargetType>(_ type: T.Type) -> MoyaProvider<T> {
		return MoyaProvider<T>()
	}

}