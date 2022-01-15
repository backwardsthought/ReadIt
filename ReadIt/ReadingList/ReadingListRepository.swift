//
// Created by Felipe Lobo on 23/08/18.
// Copyright (c) 2018 Copyisright. All rights reserved.
//

import Foundation
import Combine

class ReadingListRepository {

	private let pocketRequestCreateHandler: () -> PocketRequest?

	init(pocketRequestCreateHandler: @escaping () -> PocketRequest?) {
		self.pocketRequestCreateHandler = pocketRequestCreateHandler
	}

	func fetch() -> AnyPublisher<[Reading], Error> {
        guard let pocketRequest = pocketRequestCreateHandler() else {
			return Empty().eraseToAnyPublisher()
		}
        
        return pocketRequest
			.request(.get)
			.map { pocketReadings in
				pocketReadings
					.sorted { a, b in (a.timeUpdated ?? 0) > (b.timeUpdated ?? 0) }
					.map(Reading.init)
			}
			.receive(on: DispatchQueue.main)
			.eraseToAnyPublisher()
	}

}

private extension Reading {

    init(pocket: Pocket) {
		let dateAdded: Date?
		if let updatedTimestamp = pocket.timeUpdated {
			dateAdded = Date(timeIntervalSince1970: updatedTimestamp)
		} else {
			dateAdded = nil
		}

		let cover: Image?
		if let image = pocket.topImage {
			cover = Image(pocket: image)
		} else {
			cover = nil
		}

        self.init(
            title: pocket.title,
            source: pocket.url,
            dateAdded: dateAdded,
            excerpt: pocket.excerpt,
			cover: cover,
            images: pocket.images?.filter { ($0.src as? NSString)?.pathExtension != "svg" }.map(Image.init),
            author: pocket.authors?.first?.name,
			timeToRead: pocket.timeToRead
        )
    }

}

extension Reading.Image {

    init(pocket: Pocket.Image) {
        self.init(src: pocket.src)
    }

}
