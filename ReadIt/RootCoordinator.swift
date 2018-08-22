//
// Created by Felipe Lobo on 20/08/18.
// Copyright (c) 2018 Copyisright. All rights reserved.
//

import UIKit

class RootCoordinator: Coordinator {

	weak var window: UIWindow?
	weak var navigationController: UINavigationController?

	init(window: UIWindow) {
		self.window = window

		let viewModel = RootViewModel()

		let rootViewController = RootViewController(viewModel: viewModel)
		let navigationController = UINavigationController(rootViewController: rootViewController)

		self.navigationController = navigationController
	}

	func start() {
		window?.rootViewController = navigationController
		window?.makeKeyAndVisible()
	}

}
