//
// Created by Felipe Lobo on 22/08/18.
// Copyright (c) 2018 Copyisright. All rights reserved.
//

import Moya
import RxSwift

protocol ReadingListModel: class {

	func execute() -> Single<[Reading]>

}

class ReadingListUseCase: ReadingListModel {

	let repository: ReadingListRepository

	init(repository: ReadingListRepository) {
		self.repository = repository
	}

	func execute() -> Single<[Reading]> {
		return repository.fetch().map { pocketList in
			return pocketList.map(Reading.init)
		}
	}

}

extension Reading {

	init(pocket: Pocket) {
		self.init(title: pocket.title, source: pocket.url)
	}

}

