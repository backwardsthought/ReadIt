//
// Created by Felipe Lobo on 23/08/18.
// Copyright (c) 2018 Copyisright. All rights reserved.
//

import Moya
import RxSwift

class ReadingListRepository {

	private let client: PocketClient
	private var provider: MoyaProvider<PocketService>?

	init(client: PocketClient) {
		self.client = client
	}

	func fetch() -> Single<[Reading]> {
        let provider = client.create()
        
        self.provider = provider // Retains the provider because of reasons
        
        return provider.rx
            .request(.get)
            .map(serializePocket(response:))
	}

	private func serializePocket(response: Moya.Response) throws -> [Reading] {
		let json = try response.mapJSON()

		guard let list = (json as? NSDictionary)?.value(forKeyPath: "list") as? [String: Any?] else {
			return []
		}

		return try list.map { key, value -> Pocket in
            var dictionary = value as! [String: Any]
            
            if let imagesNode = dictionary["images"] as? [String: Any] {
                dictionary["images"] = convertToArray(node: imagesNode)
            }
            
            if let authorsNode = dictionary["authors"] as? [String: Any] {
                dictionary["authors"] = convertToArray(node: authorsNode)
            }
            
			let decoder = JSONDecoder()
			let data = try JSONSerialization.data(withJSONObject: dictionary, options: [])

			let pocket = try decoder.decode(Pocket.self, from: data)

			return pocket
		}.sorted { first, second in
			return first.timeAdded > second.timeAdded
		}.map(Reading.init)
	}

    private func convertToArray(node: [String: Any]) -> [Any] {
        return node.reduce([Any]()) { seed, tuple -> [Any] in
            return [tuple.value] + seed
        }
    }

}

private extension Reading {

    init(pocket: Pocket) {
        self.init(
            title: pocket.title,
            source: pocket.url,
            dateAdded: Date(timeIntervalSince1970: pocket.timeAdded),
            excerpt: pocket.excerpt,
            images: pocket.images?.map(Reading.Image.init),
            author: pocket.authors?.first?.name
        )
    }

}

extension Reading.Image {

    init(pocket: Pocket.Image) {
        self.init(src: pocket.src)
    }

}
