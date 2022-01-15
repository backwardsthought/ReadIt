//
//  ReadingCoordinator.swift
//  ReadIt
//
//  Created by Felipe Lobo on 26/08/19.
//  Copyright © 2019 Copyisright. All rights reserved.
//

import UIKit
import SafariServices

class ReadingCoordinator {
    
	private let session: AppSession
	private let reading: Reading

	init(session: AppSession, reading: Reading) {
		self.session = session
        self.reading = reading
    }
    
    func start(navigable: Navigable) {
		navigable.navigateTo(view: makeView(), animated: true)
    }

    private func makeView() -> ReadingViewController {
		let repository = ReadingRepository(network: session.network, reading: reading)

        let viewModel = ReadingViewModel()
        let model = ReadingInteractor(repository: repository, presentation: viewModel)

		let view = ReadingViewController(useCase: model, viewModel: viewModel)
        view.navigationDelegate = self

        return view
    }

}

extension ReadingCoordinator: ReadingNavigationDelegate {

    func present(content: URL, fromContext context: Presentable) {
        let safariViewController = SFSafariViewController(url: content)
        safariViewController.modalPresentationStyle = .overCurrentContext
        safariViewController.modalTransitionStyle = .coverVertical

        context.present(view: safariViewController, animated: true)
    }

}
