//
// Created by Felipe Lobo on 20/08/18.
// Copyright (c) 2018 Backwardstought. All rights reserved.
//

import Foundation
import UIKit
import AuthenticationServices

typealias UIKitContext = UIViewController

protocol RootNavigationDelegate: AnyObject {

	func forwardToUser()

}

class RootCoordinator {

	weak var window: UIWindow!

	let session: AppSession

	private weak var uiContext: UIKitContext?

	private var readingListCoordinator: ReadingListCoordinator?
	private var userCoordinator: UserCoordinator?

	init(window: UIWindow) {
		self.window = window

		session = AppSession()
	}

	func start() {
		let navigationController = RootNavigationController()
		navigationController.navigationBar.titleTextAttributes = [
			.font: UIFont(name: "Palatino", size: 24)!,
			.foregroundColor: UIColor.white
		]
		navigationController.navigationBar.isTranslucent = false
		navigationController.navigationBar.barTintColor = .systemBackground
		navigationController.navigationBar.tintColor = .white

		uiContext = navigationController

		let readingListCoordinator = ReadingListCoordinator(session: session)
		readingListCoordinator.rootNavigationDelegate = self
        readingListCoordinator.start(navigable: navigationController)

		self.readingListCoordinator = readingListCoordinator

		window?.rootViewController = navigationController
		window?.makeKeyAndVisible()
	}

}

extension RootCoordinator: RootNavigationDelegate {
	
	func forwardToUser() {
		let userCoordinator = UserCoordinator(session: session, presentationContextWrapper: self)
		userCoordinator.start()
		
		self.userCoordinator = userCoordinator
	}
	
}

// MARK: - Context Provider

extension RootCoordinator: AuthenticationPresentationContextWrapping {

    @objc private class PresentationContext: NSObject, ASWebAuthenticationPresentationContextProviding {

        weak var window: UIWindow!

        init(window: UIWindow) {
            self.window = window
        }

        func presentationAnchor(for session: ASWebAuthenticationSession) -> ASPresentationAnchor {
            window
        }

    }

    func getPresentationContextProvider() -> ASWebAuthenticationPresentationContextProviding {
        PresentationContext(window: window)
    }

}

// MARK: - UIKit tweaks

class RootNavigationController: UINavigationController {

	override var preferredStatusBarStyle: UIStatusBarStyle {
		.applyDarkContentIfNeeded(self)
	}

}
