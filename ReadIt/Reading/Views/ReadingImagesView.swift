//  
//  ReadingImagesView.swift
//  ReadIt
//
//  Created by Felipe Lobo on 06/09/21.
//  Copyright (c) 2021 Copyisright. All rights reserved.
//

import UIKit

final class ReadingImagesView: UIView {

	weak var dataSource: UICollectionViewDataSource? {
		didSet {
			imageCollectionView.dataSource = dataSource
		}
	}

	weak var delegate: UICollectionViewDelegate? {
		didSet {
			imageCollectionView.delegate = delegate
		}
	}

	let imageCollectionView: UICollectionView = {
		let flowLayout = UICollectionViewFlowLayout()
		flowLayout.itemSize = CGSize(width: 88, height: 88)
		flowLayout.minimumInteritemSpacing = 8
		flowLayout.scrollDirection = .horizontal

		let imageCollectionView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
		imageCollectionView.translatesAutoresizingMaskIntoConstraints = false
		imageCollectionView.backgroundColor = .clear
		imageCollectionView.clipsToBounds = false

		return imageCollectionView
	}()

	init() {
		super.init(frame: .zero)

		addSubview(imageCollectionView)

		imageCollectionView.register(ReadingImageViewCell.self)

		setupLayout()
	}

	required init?(coder aDecoder: NSCoder) {
		fatalError("You should not use init?(coder:), ever!")
	}

	func reloadData() {
		imageCollectionView.reloadData()
	}

	private func setupLayout() {
		addConstraints(matchingEdgesOf: imageCollectionView)
	}

}
