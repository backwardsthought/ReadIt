//
// Created by Felipe Lobo on 21/08/18.
// Copyright (c) 2018 Copyisright. All rights reserved.
//

import UIKit

extension UIView {

	func addConstraintsForAllEdges(of item: UIView, insets: UIEdgeInsets = .zero) {
		let constraints: [NSLayoutConstraint] = [
			.equal(from: item, to: self, attr: .top, constant: insets.top),
			.equal(from: item, to: self, attr: .left, constant: insets.left),
			.equal(from: self, to: item, attr: .bottom, constant: insets.bottom),
			.equal(from: self, to: item, attr: .right, constant: insets.right)
		]

		self.addConstraints(constraints)
	}

	func addConstraintsForPositionCenter(of item: UIView, sprain: CGPoint = .zero) {
		let constraints: [NSLayoutConstraint] = [
			.equal(from: item, to: self, attr: .centerX, constant: sprain.x),
			.equal(from: item, to: self, attr: .centerY, constant: sprain.y)
		]

		self.addConstraints(constraints)
	}

}
