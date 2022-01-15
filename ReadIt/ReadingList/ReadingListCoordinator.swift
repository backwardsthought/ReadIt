//
//  ReadingListCoordinator.swift
//  ReadIt
//
//  Created by Felipe Lobo on 26/08/19.
//  Copyright © 2019 Copyisright. All rights reserved.
//

import UIKit
import AuthenticationServices

protocol ReadingListNavigation: AnyObject{

	func forwardTo(reading: Reading)

	func forwardToUser()

}

class ReadingListCoordinator {

	let session: AppSession

	weak var rootNavigationDelegate: RootNavigationDelegate?

	private var readingCoordinator: ReadingCoordinator?
	private weak var navigable: Navigable?

	init(session: AppSession) {
		self.session = session
	}

	func start(navigable: Navigable) {
		self.navigable = navigable

		let repository = ReadingListRepository { [session] in
			guard let authorization = session.authorizations[.pocket] else { return nil }
			return PocketRequest(network: session.network, authorization: authorization)
		}

		let viewModel = ReadingListViewModel()
		let model = ReadingListInteractor(repository: repository, presentation: viewModel)

		let view = ReadingListViewController(useCase: model, viewModel: viewModel)
		view.navigation = self

		navigable.navigateTo(view: view, animated: true)
	}

}

extension ReadingListCoordinator: ReadingListNavigation {

	func forwardToUser() {
		rootNavigationDelegate?.forwardToUser()
	}

	func forwardTo(reading: Reading) {
		guard let navigable = navigable else {
			return
		}

		let readingCoordinator = ReadingCoordinator(session: session, reading: reading)
		readingCoordinator.start(navigable: navigable)

		self.readingCoordinator = readingCoordinator // Retain
	}

}
