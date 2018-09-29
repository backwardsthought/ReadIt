//
// Created by Felipe Lobo on 23/08/18.
// Copyright (c) 2018 Copyisright. All rights reserved.
//

import Moya
import RxSwift

class ReadingListRepository {

	private let client: PocketClient
	private var provider: MoyaProvider<PocketService>

	init(client: PocketClient) {
		self.client = client
		self.provider = client.create()
	}

	func login() -> Single<Bool> {
		return client.login()
	}

	func fetch() -> Single<[Pocket]> {
		provider = client.create()
		return provider.rx
				.request(.get)
				.map(serializePocket(response:))
	}

	private func serializePocket(response: Moya.Response) throws -> [Pocket] {
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
