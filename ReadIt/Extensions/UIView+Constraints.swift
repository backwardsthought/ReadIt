//
// Created by Felipe Lobo on 21/08/18.
// Copyright (c) 2018 Copyisright. All rights reserved.
//

import UIKit

extension UIView {

	func addConstraints(matchingEdgesOf view: UIView, margins: NSDirectionalEdgeInsets? = nil) {
		if let margins = margins {
			addConstraintsRelativeToMargin(matchingEdgesOf: view, margins: margins)
		} else {
			addConstraints([
				view.topAnchor.constraint(equalTo: topAnchor),
				view.leadingAnchor.constraint(equalTo: leadingAnchor),
				bottomAnchor.constraint(equalTo: view.bottomAnchor),
				trailingAnchor.constraint(equalTo: view.trailingAnchor)
			])
		}
	}

	private func addConstraintsRelativeToMargin(matchingEdgesOf view: UIView, margins: NSDirectionalEdgeInsets) {
		directionalLayoutMargins = margins
		addConstraints([
			view.topAnchor.constraint(equalTo: layoutMarginsGuide.topAnchor),
			view.leadingAnchor.constraint(equalTo: layoutMarginsGuide.leadingAnchor),
			layoutMarginsGuide.bottomAnchor.constraint(equalTo: view.bottomAnchor),
			layoutMarginsGuide.trailingAnchor.constraint(equalTo: view.trailingAnchor)
		])
	}

	func addConstraints(forPositionCenterOf view: UIView, sprain: CGPoint = .zero) {
		addConstraints([
			view.centerXAnchor.constraint(equalTo: centerXAnchor, constant: sprain.x),
			view.centerYAnchor.constraint(equalTo: centerYAnchor, constant: sprain.y)
		])
	}

}
