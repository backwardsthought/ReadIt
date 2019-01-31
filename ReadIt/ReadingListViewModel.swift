//
// Created by Felipe Lobo on 21/08/18.
// Copyright (c) 2018 Copyisright. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

protocol ReadingListViewModelType: class {

	var readingList: BehaviorRelay<[Reading]> { get }

	var isLogged: BehaviorRelay<Bool> { get }

	func load()

	func login()

	func image(for reading: Reading) -> Single<UIImage>

}

class ReadingListViewModel: ReadingListViewModelType {

	private var executionDisposable: Disposable? = nil
	private var loginDisposable: Disposable? = nil

	let model: ReadingListModel

	let readingList: BehaviorRelay<[Reading]>
	let isLogged: BehaviorRelay<Bool>

	private let imagesCache: ReplaySubject<(String, UIImage)>

	deinit {
		executionDisposable?.dispose()
		loginDisposable?.dispose()
	}

	init(model: ReadingListModel) {
		self.model = model

		readingList = BehaviorRelay(value: [])
		isLogged = BehaviorRelay(value: false)
		imagesCache = ReplaySubject.create(bufferSize: 20)
	}

	func load() {
		executionDisposable?.dispose()
		executionDisposable = model.execute()
				.subscribe(onSuccess: readingList.accept)
	}

	func image(for reading: Reading) -> Single<UIImage> {
		let downloading = model
				.download(imageFor: reading)
				.map { (reading.id, $0) }
				.do(onSuccess: imagesCache.onNext)

		let cached = Observable<(String, UIImage)>
				.create { [weak self] observer in
					let disposable = self?.imagesCache.bind(to: observer)

					observer.onCompleted()

					return Disposables.create {
						disposable?.dispose()
					}
				}
				.filter { reading.id == $0.0 }
				.map { $0.1 }
				.asMaybe()

		return cached.ifEmpty(switchTo: downloading)
	}

	func login() {
		loginDisposable?.dispose()
		loginDisposable = model.login()
				.do(onSuccess: { [weak self] _ in self?.load() })
				.subscribe(onSuccess: isLogged.accept)
	}

}
