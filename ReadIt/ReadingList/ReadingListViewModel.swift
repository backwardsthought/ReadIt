//
// Created by Felipe Lobo on 21/08/18.
// Copyright (c) 2018 Copyisright. All rights reserved.
//

import Combine

protocol ReadingListPresentation: AnyObject {

    func onLoading(readingsList: AnyPublisher<[Reading], Error>)

}

class ReadingListViewModel {

	@Published var readingsList: [Reading] = []

	init() {}
    
}

extension ReadingListViewModel: ReadingListPresentation {

	func onLoading(readingsList: AnyPublisher<[Reading], Error>) {
		readingsList
			.replaceError(with: [])
			.assign(to: &$readingsList)
	}

}
