//
//  ReadingViewModel.swift
//  ReadIt
//
//  Created by Felipe Lobo on 26/08/19.
//  Copyright © 2019 Copyisright. All rights reserved.
//

import RxCocoa
import RxSwift

protocol ReadingViewModelType: class {
    
    var reading: BehaviorRelay<Reading?> { get }
    
    var images: BehaviorRelay<[Data]> { get }
    
    var imagesCount: Int { get }
    
}

protocol ReadingPresentation: class {
    
    func onLoading(reading: Single<Reading>)
    
    func onDownloading(images: Observable<Data>, count: Int)
    
}

class ReadingViewModel: ReadingViewModelType, ReadingPresentation {
    
    private var executionDisposable: Disposable? = nil
    private var downloadDisposable: Disposable? = nil
    
    let reading: BehaviorRelay<Reading?>
    
    var imagesCount: Int
    let images: BehaviorRelay<[Data]>
    
    deinit {
        executionDisposable?.dispose()
    }
    
    init() {
        reading = BehaviorRelay(value: nil)
        imagesCount = 0
        images = BehaviorRelay(value: [])
    }
    
    func onLoading(reading: Single<Reading>) {
        executionDisposable?.dispose()
        executionDisposable = reading.subscribe(onSuccess: self.reading.accept)
    }
    
    func onDownloading(images: Observable<Data>, count: Int) {
        imagesCount = count
        downloadDisposable?.dispose()
        downloadDisposable = images.subscribe { [weak self] event in
            if case .next(let data) = event, var currentImages = self?.images.value {
                currentImages.append(data)
                self?.images.accept(currentImages)
            }
        }
    }
    
}
