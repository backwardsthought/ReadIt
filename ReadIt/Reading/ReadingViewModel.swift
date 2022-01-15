//
//  ReadingViewModel.swift
//  ReadIt
//
//  Created by Felipe Lobo on 26/08/19.
//  Copyright © 2019 Copyisright. All rights reserved.
//

import Foundation
import Combine

protocol ReadingPresentation: AnyObject {
    
	func onLoading(reading: Just<Reading>)
    
    func onDownloading(images: AnyPublisher<Data, Error>, count: Int)
    
}

class ReadingViewModel {

	@Published(initialValue: nil)
	var reading: Reading?
    
	@Published(initialValue: [])
	var images: [Data]
    
	var imagesCount: Int = 0

    private var downloadCancellable: AnyCancellable? = nil

    deinit {
        downloadCancellable?.cancel()
        downloadCancellable = nil
    }

    init() {}
    
}

extension ReadingViewModel: ReadingPresentation {

    func onLoading(reading: Just<Reading>) {
        reading
			.map(Optional.init)
            .assign(to: &$reading)
    }

    func onDownloading(images: AnyPublisher<Data, Error>, count: Int) {
        imagesCount = count
		downloadCancellable = images
			.catch { error ->  Empty<Data, Never> in
				print(error)
				return Empty()
			}
            .sink { [weak self] data in
                self?.images.append(data)
            }
    }

}
