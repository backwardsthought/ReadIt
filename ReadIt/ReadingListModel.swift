//
// Created by Felipe Lobo on 22/08/18.
// Copyright (c) 2018 Copyisright. All rights reserved.
//

import Moya
import RxSwift

protocol ReadingListModel: class {

	func execute() -> Single<[Reading]>

	func login() -> Single<Bool>

	func download(imageFor reading: Reading) -> Single<UIImage>

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

	func login() -> Single<Bool> {
		return repository.login()
	}

	func download(imageFor reading: Reading) -> Single<UIImage> {
		guard let imageUrl = reading.imageUrl else {
			fatalError() // TODO some message please
		}

		return repository.downloadImage(url: imageUrl)
				.map { data in
					guard let image = UIImage(data: data) else {
						return UIImage() // FIXME what the fuck
					}
					return image
				}
	}

}

extension Reading {

	init(pocket: Pocket) {
		let url: URL?

		if let imageUrl = pocket.imageUrl {
			url = URL(string: imageUrl)
		} else {
			url = nil
		}

		self.init(id: pocket.id, title: pocket.title, source: pocket.url, imageUrl: url)
	}

}
