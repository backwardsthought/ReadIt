//
// Created by Felipe Lobo on 21/08/18.
// Copyright (c) 2018 Copyisright. All rights reserved.
//

import RxCocoa
import RxSwift

protocol ReadingListViewModelType: class {

	var readingList: BehaviorRelay<[Reading]> { get }

}

protocol ReadingListPresentation: class {
    
    func onLoading(readingList: Single<[Reading]>)
    
}

class ReadingListViewModel: ReadingListViewModelType, ReadingListPresentation {

	private var executionDisposable: Disposable? = nil

	let readingList: BehaviorRelay<[Reading]>

	deinit {
		executionDisposable?.dispose()
	}

	init() {
		readingList = BehaviorRelay(value: [])
	}
    
    func onLoading(readingList: Single<[Reading]>) {
        executionDisposable?.dispose()
        executionDisposable = readingList.subscribe(onSuccess: self.readingList.accept)
    }
    
}
