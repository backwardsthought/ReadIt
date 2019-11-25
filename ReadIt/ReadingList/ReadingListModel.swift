//
// Created by Felipe Lobo on 22/08/18.
// Copyright (c) 2018 Copyisright. All rights reserved.
//

import RxSwift

protocol ReadingListUseCase: class {

	func loadContent()

}

class ReadingListModel: ReadingListUseCase {

    weak var presentation: ReadingListPresentation?
	let repository: ReadingListRepository

    init(repository: ReadingListRepository, presentation: ReadingListPresentation) {
		self.repository = repository
        self.presentation = presentation
	}

    func loadContent() {
        presentation?.onLoading(readingList: repository.fetch())
	}

}
