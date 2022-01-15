//
// Created by Felipe Lobo on 22/08/18.
// Copyright (c) 2018 Copyisright. All rights reserved.
//

protocol ReadingListUseCase: AnyObject {

	func loadContent()

}

class ReadingListInteractor: ReadingListUseCase {

    weak var presentation: ReadingListPresentation?
	let repository: ReadingListRepository

    init(repository: ReadingListRepository, presentation: ReadingListPresentation) {
		self.repository = repository
        self.presentation = presentation
	}

    func loadContent() {
        presentation?.onLoading(readingsList: repository.fetch())
	}

}
