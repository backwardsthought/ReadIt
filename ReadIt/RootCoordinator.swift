//
// Created by Felipe Lobo on 20/08/18.
// Copyright (c) 2018 Copyisright. All rights reserved.
//

import Foundation
import UIKit

class RootCoordinator: Coordinator {

	weak var window: UIWindow?
	weak var navigationController: UINavigationController?

	let appState: AppState

	init(window: UIWindow) {
		self.window = window

		let appState = AppState()
		self.appState = appState

		let client = Client()

		let repository = ReadingListRepository(client: client)

		let model = ReadingListUseCase(repository: repository)

		let viewModel = ReadingListViewModel(model: model)

		let rootViewController = ReadingListViewController(viewModel: viewModel)

		let navigationController = UINavigationController(rootViewController: rootViewController)
		navigationController.navigationBar.titleTextAttributes = [.font: UIFont(name: "Palatino", size: 18)!]
		navigationController.navigationBar.barStyle = .black

		self.navigationController = navigationController
	}

	func start() {
		window?.rootViewController = navigationController
		window?.makeKeyAndVisible()
	}

}
