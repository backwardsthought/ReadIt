//
// Created by Felipe Lobo on 21/08/18.
// Copyright (c) 2018 Copyisright. All rights reserved.
//

import RxSwift
import RxCocoa

protocol ReadingListViewModelType: class {

	var readingList: BehaviorRelay<[Reading]> { get }

	func load()

}

class ReadingListViewModel: ReadingListViewModelType {

	private let disposeBag = DisposeBag()

	let model: ReadingListModel
	let readingList: BehaviorRelay<[Reading]>

	init(model: ReadingListModel) {
		self.model = model

		readingList = BehaviorRelay(value: [])
	}

	func load() {
		model.execute()
				.subscribe(onSuccess: readingList.accept)
				.disposed(by: disposeBag)
	}

}
