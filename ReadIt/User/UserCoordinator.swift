//  
//  UserCoordinator.swift
//  ReadIt
//
//  Created by Felipe Lobo on 27/05/21.
//  Copyright (c) 2021 Copyisright. All rights reserved.
//

import Foundation
import Combine

class UserCoordinator {

	let session: AppSession
	let presentationContextWrapper: AuthenticationPresentationContextWrapping

	private var pocketAuthService: PocketAuthService?
	private var cancellables: [AnyCancellable] = []

	init(session: AppSession, presentationContextWrapper: AuthenticationPresentationContextWrapping) {
		self.session = session
		self.presentationContextWrapper = presentationContextWrapper
	}

	func start() {
		let presentationContextProvider = presentationContextWrapper.getPresentationContextProvider()
		let pocketAuthService = PocketAuthService(
			network: session.network,
			presentationContextProvider: presentationContextProvider
		)

		pocketAuthService.login()
			.sink(receiveCompletion: { completion in
				print(completion)
			}, receiveValue: { [session] auth in
				session.add(authorization: auth, for: .pocket)
				print(auth)
			})
			.store(in: &cancellables)
		
		self.pocketAuthService = pocketAuthService
	}

}
