//
//  ReadingModel.swift
//  ReadIt
//
//  Created by Felipe Lobo on 26/08/19.
//  Copyright © 2019 Copyisright. All rights reserved.
//

import Foundation
import Combine

protocol ReadingUseCase: AnyObject {
    
    func loadContent()
    
}

class ReadingInteractor: ReadingUseCase {
    
    let repository: ReadingRepository
    weak var presentation: ReadingPresentation?

    init(repository: ReadingRepository, presentation: ReadingPresentation) {
        self.repository = repository
        self.presentation = presentation
    }
    
    func loadContent() {
		presentation?.onLoading(reading: repository.fetch())
        presentation?.onDownloading(
            images: repository.downloadImages(),
            count: repository.imagesCount()
        )
    }
    
}
