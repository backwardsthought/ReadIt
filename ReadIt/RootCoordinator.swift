//
// Created by Felipe Lobo on 20/08/18.
// Copyright (c) 2018 Copyisright. All rights reserved.
//

import Foundation
import UIKit
import RxSwift

class RootNavigationController: UINavigationController {

	override var preferredStatusBarStyle: UIStatusBarStyle {
		return self.topViewController?.preferredStatusBarStyle ?? .default
	}

}

class RootCoordinator: Coordinator {

	weak var window: UIWindow?
	weak var navigationController: RootNavigationController?

	let appState: AppState

	init(window: UIWindow) {
		self.window = window

		let client = PocketClient()

		let appState = AppState(pocketClient: client)
		self.appState = appState

		let repository = ReadingListRepository(client: client)

		let model = ReadingListUseCase(repository: repository)

		let viewModel = ReadingListViewModel(model: model)

		let rootViewController = ReadingListViewController(viewModel: viewModel)

		let navigationController = RootNavigationController(rootViewController: rootViewController)
		navigationController.navigationBar.titleTextAttributes = [
			.font: UIFont(name: "Palatino", size: 24)!,
			.foregroundColor: UIColor.white
		]
		navigationController.navigationBar.isTranslucent = false
		navigationController.navigationBar.barTintColor = UIColor(white: 0.1, alpha: 1)
		navigationController.navigationBar.tintColor = UIColor(white: 0.9, alpha: 1)

		self.navigationController = navigationController
	}

	func start() {
		window?.rootViewController = navigationController
		window?.makeKeyAndVisible()
	}

}
