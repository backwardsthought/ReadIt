//
//  AppDelegate.swift
//  ReadIt
//
//  Created by Felipe Lobo on 20/08/18.
//  Copyright © 2018 Copyisright. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

	var window: UIWindow?
	var coordinator: RootCoordinator?

	func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
		let window = UIWindow()

		let coordinator = RootCoordinator(window: window)

		self.coordinator = coordinator
		self.window = window

		coordinator.start()

		return true
	}

}
