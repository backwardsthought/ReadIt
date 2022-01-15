//
//  ReadingRepository.swift
//  ReadIt
//
//  Created by Felipe Lobo on 26/08/19.
//  Copyright © 2019 Copyisright. All rights reserved.
//

import Foundation
import Combine

class ReadingRepository {

    let network: NetworkSession

    private let reading: Reading

    init(network: NetworkSession, reading: Reading) {
        self.network = network
        self.reading = reading
    }

    func fetch() -> Just<Reading> {
        Just(reading)
    }

    func imagesCount() -> Int {
        reading.images?.count ?? 0
    }

    func downloadImages() -> AnyPublisher<Data, Error> {
        let images = reading.images ?? []
        let imagePublishers = images
            .map { [network] image in
                network.session
                    .dataTaskPublisher(for: image.src)
                    .map(\.data)
            }
		return Publishers.MergeMany(imagePublishers)
			.mapError { $0 as Error }
            .handleEvents(receiveCompletion: { completion in
                if case .failure(let error) = completion {
                    print(error)
                }
            })
            .receive(on: DispatchQueue.main)
			.eraseToAnyPublisher()
    }

}
