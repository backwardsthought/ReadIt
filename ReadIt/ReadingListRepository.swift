//
// Created by Felipe Lobo on 23/08/18.
// Copyright (c) 2018 Copyisright. All rights reserved.
//

import Moya
import RxSwift

class ReadingListRepository {

	let client: Client

	init(client: Client) {
		self.client = client
	}

	func fetch() -> Single<[Pocket]> {
		let provider = client.create(PocketService.self)
		return provider.rx
				.request(.get)
				.do(onError: { error in
					print(error)
				})
				.map(self.serializePocketResponse)
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
