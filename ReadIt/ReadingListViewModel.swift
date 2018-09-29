//
// Created by Felipe Lobo on 21/08/18.
// Copyright (c) 2018 Copyisright. All rights reserved.
//

import RxSwift
import RxCocoa

protocol ReadingListViewModelType: class {

	var readingList: BehaviorRelay<[Reading]> { get }

	var isLogged: BehaviorRelay<Bool> { get }

	func load()

	func login()

}

class ReadingListViewModel: ReadingListViewModelType {

	private var executionDisposable: Disposable? = nil
	private var loginDisposable: Disposable? = nil

	let model: ReadingListModel

	let readingList: BehaviorRelay<[Reading]>
	let isLogged: BehaviorRelay<Bool>

	deinit {
		executionDisposable?.dispose()
		loginDisposable?.dispose()
	}

	init(model: ReadingListModel) {
		self.model = model

		readingList = BehaviorRelay(value: [])
		isLogged = BehaviorRelay(value: false)
	}

	func load() {
		executionDisposable?.dispose()
		executionDisposable = model.execute()
				.subscribe(onSuccess: readingList.accept)
	}

	func login() {
		loginDisposable?.dispose()
		loginDisposable = model.login()
				.do(onSuccess: { [weak self] _ in self?.load() })
				.subscribe(onSuccess: isLogged.accept)
	}

}
