//
//  ReadingRepository.swift
//  ReadIt
//
//  Created by Felipe Lobo on 26/08/19.
//  Copyright © 2019 Copyisright. All rights reserved.
//

import Alamofire
import RxSwift

class ReadingRepository {
    
    private let reading: Reading
    
    init(reading: Reading) {
        self.reading = reading
    }
    
    func fetch() -> Single<Reading> {
        return Single.just(reading)
    }
    
    func imagesCount() -> Int {
        return reading.images?.count ?? 0
    }
    
    func downloadImages() -> Observable<Data> {
        guard let images = reading.images else {
            return Observable.empty()
        }
        
        let observables = images
            .map(requestFrom(image:))
            .map(downloadImage(request:))
        
        return Observable.concat(observables)
    }
    
    // MARK: Private
    
    private func requestFrom(image: Reading.Image) -> DataRequest {
        return Alamofire.request(image.src)
    }
    
    private func downloadImage(request: DataRequest) -> Observable<Data> {
        return Observable.create { observer in
            request.responseData { dataResponse in
                let result = dataResponse.result
                
                if case .success(let data) = result {
                    observer.on(.next(data))
                    observer.on(.completed)
                } else if case .failure(let error) = result {
                    observer.on(.error(error))
                }
            }
            
            return Disposables.create {
                request.cancel()
            }
        }
    }
    
}
