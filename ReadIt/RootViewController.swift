//
//  RootViewController.swift
//  ReadIt
//
//  Created by Felipe Lobo on 20/08/18.
//  Copyright © 2018 Copyisright. All rights reserved.
//

import UIKit

class RootViewController: UIViewController {

	let viewModel: RootViewModelType

	init(viewModel: RootViewModelType) {
		self.viewModel = viewModel
		super.init(nibName: nil, bundle: nil)
	}

	required init?(coder aDecoder: NSCoder) {
		fatalError("Not implemented")
	}

	override func viewDidLoad() {
		super.viewDidLoad()

		view.backgroundColor = .white

		let helloWorldLabel = UILabel()
		helloWorldLabel.translatesAutoresizingMaskIntoConstraints = false
		helloWorldLabel.text = viewModel.text

		view.addSubview(helloWorldLabel)

		helloWorldLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
		helloWorldLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
	}

}

