//  
//  ReadingBottomView.swift
//  ReadIt
//
//  Created by Felipe Lobo on 06/09/21.
//  Copyright (c) 2021 Copyisright. All rights reserved.
//

import UIKit

final class ReadingBottomView: UIView {

	let neverButton: UIButton = {
		let neverButton = UIButton()
		neverButton.translatesAutoresizingMaskIntoConstraints = false
		neverButton.setTitle("Never", for: .normal)

		return neverButton
	}()

	let readItButton: UIButton = {
		let readItButton = UIButton()
		readItButton.translatesAutoresizingMaskIntoConstraints = false
		readItButton.setTitle("Read it", for: .normal)
		readItButton.titleLabel?.font = .systemFont(ofSize: 20)

		return readItButton
	}()

	let laterButton: UIButton = {
		let laterButton = UIButton()
		laterButton.translatesAutoresizingMaskIntoConstraints = false
		laterButton.setTitle("Later", for: .normal)

		return laterButton
	}()

	init() {
		super.init(frame: .zero)

		addSubview(neverButton)
		addSubview(readItButton)
		addSubview(laterButton)

		setupLayout()
	}

	required init?(coder aDecoder: NSCoder) {
		fatalError("You should not use init?(coder:), ever!")
	}

	private func setupLayout() {
		addConstraints([
			neverButton.topAnchor.constraint(equalTo: topAnchor),
			neverButton.leadingAnchor.constraint(equalTo: leadingAnchor),
			bottomAnchor.constraint(equalTo: neverButton.bottomAnchor),

			readItButton.topAnchor.constraint(equalTo: topAnchor),
			readItButton.centerXAnchor.constraint(equalTo: centerXAnchor),
			bottomAnchor.constraint(equalTo: readItButton.bottomAnchor),

			laterButton.topAnchor.constraint(equalTo: topAnchor),
			bottomAnchor.constraint(equalTo: laterButton.bottomAnchor),
			rightAnchor.constraint(equalTo: laterButton.rightAnchor)
		])
	}

}
