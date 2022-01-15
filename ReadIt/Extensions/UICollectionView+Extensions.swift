//  
//  UICollectionView+Extensions.swift
//  ReadIt
//
//  Created by Felipe Lobo on 07/09/21.
//  Copyright (c) 2021 Copyisright. All rights reserved.
//

import UIKit

extension UICollectionView {

	func register<T: UICollectionViewCell>(_: T.Type) {
		register(T.self, forCellWithReuseIdentifier: T.reuseIdentifier)
	}

	func dequeueReusableCell<T: UICollectionViewCell>(for indexPath: IndexPath) -> T {
		guard let cell = dequeueReusableCell(withReuseIdentifier: T.reuseIdentifier, for: indexPath) as? T else {
			fatalError("Could not dequeue cell with identifier: \(T.reuseIdentifier)")
		}
		return cell
	}

	func dequeueReusableCell<T: UICollectionViewCell>(item: Int) -> T {
		let indexPath = IndexPath(item: item, section: 0)
		return dequeueReusableCell(for: indexPath)
	}

}
