//
//  ReadingViewController.swift
//  ReadIt
//
//  Created by Felipe Lobo on 26/08/19.
//  Copyright © 2019 Copyisright. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift

class ReadingViewController: UIViewController {
    
    let useCase: ReadingUseCase
    let viewModel: ReadingViewModelType
    
    var readingView: ReadingView {
        return view as! ReadingView
    }
    
    private let disposeBag = DisposeBag()
    private var images: [UIImage]? = nil
    
    init(useCase: ReadingUseCase, viewModel: ReadingViewModelType) {
        self.useCase = useCase
        self.viewModel = viewModel
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("You should not use init?(coder:), ever!")
    }
    
    override func loadView() {
        let readingView = ReadingView()
        
        readingView.imageCollectionView.register(ReadingImageViewCell.self, forCellWithReuseIdentifier: .genericIdentifier)
        readingView.imageCollectionView.dataSource = self
        readingView.imageCollectionView.delegate = self
        
        view = readingView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel.reading
            .subscribe(onNext: { [weak self] reading in
                if let reading = reading {
                    self?.update(reading: reading)
                }
            })
            .disposed(by: disposeBag)
        
        viewModel.images
            .subscribe(onNext: update(downloadedImages:))
            .disposed(by: disposeBag)
        
        useCase.loadContent()
    }
    
    // MARK: Updating
    
    private func update(reading: Reading) {
        let readingView = view as! ReadingView
        
        readingView.authorLabel.text = reading.author
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyyy"
        
        readingView.dateLabel.text = dateFormatter.string(from: reading.dateAdded)
        
        readingView.titleLabel.text = reading.title
        readingView.detailLabel.text = reading.excerpt
        
        readingView.imageContainer.isHidden = reading.images == nil
    }
    
    private func update(downloadedImages images: [Data]) {
        self.images = images.compactMap(UIImage.init)
        readingView.imageCollectionView.reloadData()
        readingView.backgroundImage = self.images?.first
    }
    
}

extension ReadingViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        let layoutMargins = readingView.layoutMargins
        return UIEdgeInsets(top: 0, left: layoutMargins.left - 4, bottom: 0, right: layoutMargins.right - 4)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.imagesCount
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: .genericIdentifier, for: indexPath) as! ReadingImageViewCell
        
        if let images = self.images, indexPath.item < images.count {
            let image = images[indexPath.item]
            cell.imageView.image = image
        }
        
        return cell
    }
    
}

fileprivate extension String {
    
    static var genericIdentifier: String {
        return "Generic Identifier"
    }
    
}
