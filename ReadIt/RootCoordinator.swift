//
// Created by Felipe Lobo on 20/08/18.
// Copyright (c) 2018 Copyisright. All rights reserved.
//

import Foundation
import UIKit
import RxSwift
import AuthenticationServices

class RootNavigationController: UINavigationController {

	override var preferredStatusBarStyle: UIStatusBarStyle {
		return .applyDarkContentIfNeeded(self)
	}

}

class RootCoordinator: Coordinator {

	weak var window: UIWindow!
    weak var navigationController: RootNavigationController!
    
    var readingListCoordinator: ReadingListCoordinator?

	init(window: UIWindow) {
		self.window = window

		let navigationController = RootNavigationController()
        navigationController.navigationBar.titleTextAttributes = [
			.font: UIFont(name: "Palatino", size: 24)!,
			.foregroundColor: UIColor.invertedColors
		]
		navigationController.navigationBar.isTranslucent = false
;		navigationController.navigationBar.barTintColor = .dynamicSystem
		navigationController.navigationBar.tintColor = .invertedColors
//		navigationController.navigationBar.setBackgroundImage(UIImage(), for: .default)

		self.navigationController = navigationController
        
        let pocket = PocketClient(contextProvider: getContextProvider())
        readingListCoordinator = ReadingListCoordinator(pocket: pocket)
	}

	func start() {
        readingListCoordinator?.start(navigable: navigationController)
        
		window?.rootViewController = navigationController
		window?.makeKeyAndVisible()
	}

}

// MARK: - Content Provider

extension RootCoordinator {
    
    @objc private class ContextProvider: NSObject, ASWebAuthenticationPresentationContextProviding {
        
        weak var window: UIWindow!
        
        init(window: UIWindow) {
            self.window = window
        }
        
        func presentationAnchor(for session: ASWebAuthenticationSession) -> ASPresentationAnchor {
            return self.window
        }
        
    }
    
    func getContextProvider() -> ASWebAuthenticationPresentationContextProviding {
        return ContextProvider(window: self.window)
    }
    
}
