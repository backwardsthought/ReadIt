//
// Created by Felipe Lobo on 21/08/18.
// Copyright (c) 2018 Copyisright. All rights reserved.
//

import Foundation

protocol RootViewModelType: class {

	var text: String { get }

}

class RootViewModel: RootViewModelType {

	let text: String

	init() {
		text = "Hello World"
	}

}