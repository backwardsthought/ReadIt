//
// Created by Felipe Lobo on 21/08/18.
// Copyright (c) 2018 Copyisright. All rights reserved.
//

import RxSwift

protocol ReadingListViewModelType: class {

	var readingList: BehaviorSubject<[Reading]> { get }

}

class ReadingListViewModel: ReadingListViewModelType {

	private(set) var readingList: BehaviorSubject<[Reading]>

	init() {
		readingList = BehaviorSubject(value: [])
	}

}