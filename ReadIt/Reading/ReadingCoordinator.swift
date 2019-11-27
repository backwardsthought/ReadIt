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
    
    private let reading: Reading
    
    weak private var navigable: Navigable?
    
    init(reading: Reading) {
        self.reading = reading
    }
    
    func start(navigable: Navigable) {
        ReadingRouter().navigate(navigable: navigable, toReading: create())
    }
    
    private func create() -> ReadingViewController {
        let repository = ReadingRepository(reading: reading)
        
        let viewModel = ReadingViewModel()
        let model = ReadingModel(repository: repository, presentation: viewModel)
        let view = ReadingViewController(useCase: model, viewModel: viewModel)

        view.navigationDelegate = self
        
        return view
    }
    
}

extension ReadingCoordinator: ReadingNavigationDelegate {

    func present(content: URL, fromContext context: Presentable) {
        let safariViewController = SFSafariViewController(url: content, entersReaderIfAvailable: true)
        safariViewController.modalPresentationStyle = .overCurrentContext
        safariViewController.modalTransitionStyle = .coverVertical

        context.present(view: safariViewController, animated: true)
    }

}
