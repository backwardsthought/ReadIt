//  
//  ReusableView.swift
//  ReadIt
//
//  Created by Felipe Lobo on 07/09/21.
//  Copyright (c) 2021 Copyisright. All rights reserved.
//

import UIKit

protocol ReusableView: AnyObject {
	static var reuseIdentifier: String { get }
}

extension ReusableView where Self: UIView {
	static var reuseIdentifier: String {
		return String(describing: Self.self)
	}
}

extension UITableViewCell: ReusableView {}

extension UICollectionViewCell: ReusableView {}
