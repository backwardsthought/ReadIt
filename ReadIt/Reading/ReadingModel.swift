//
//  ReadingModel.swift
//  ReadIt
//
//  Created by Felipe Lobo on 26/08/19.
//  Copyright © 2019 Copyisright. All rights reserved.
//

import RxSwift

protocol ReadingUseCase: class {
    
    func loadContent()
    
}

class ReadingModel: ReadingUseCase {
    
    weak var presentation: ReadingPresentation?
    let repository: ReadingRepository
    
    init(repository: ReadingRepository, presentation: ReadingPresentation) {
        self.repository = repository
        self.presentation = presentation
    }
    
    func loadContent() {
        presentation?.onLoading(reading: repository.fetch())
        presentation?.onDownloading(images: repository.downloadImages(), count: repository.imagesCount())
    }
    
}
