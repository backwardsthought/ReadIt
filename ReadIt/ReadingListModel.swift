//
// Created by Felipe Lobo on 22/08/18.
// Copyright (c) 2018 Copyisright. All rights reserved.
//

import Moya

protocol ReadingListModelType: class {

	func loadReadingList(to viewModel: ReadingListViewModel)

}

class ReadingListModel: ReadingListModelType {

	func loadReadingList(to viewModel: ReadingListViewModel) {
		let provider = MoyaProvider<PocketService>()

		provider.request(.get) { result in
			if case .success(let response) = result{
				do {
					let pocketList = try self.serializePocketResponse(response: response)
					let readingsList = pocketList.map(Reading.init)

					viewModel.readingList.on(.next(readingsList))
				} catch {
					print(error)
				}
			}
		}
	}

	private func serializePocketResponse(response: Moya.Response) throws -> [Pocket] {
		let json = try response.mapJSON()

		guard let list = (json as? NSDictionary)?.value(forKeyPath: "list") as? [String: Any?] else {
			return []
		}

		return try list.map { key, value -> Pocket in
			let decoder = JSONDecoder()
			let data = try JSONSerialization.data(withJSONObject: value, options: [])

			return try decoder.decode(Pocket.self, from: data)
		}
	}

}

extension Reading {

	init(pocket: Pocket) {
		self.init(title: pocket.title, source: pocket.url)
	}

}

