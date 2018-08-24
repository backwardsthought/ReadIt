//
// Created by Felipe Lobo on 23/08/18.
// Copyright (c) 2018 Copyisright. All rights reserved.
//

import RxSwift

protocol Model {

	associatedtype Result

	func execute() -> Single<Result>

}