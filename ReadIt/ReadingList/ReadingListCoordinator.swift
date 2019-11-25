//
//  ReadingListCoordinator.swift
//  ReadIt
//
//  Created by Felipe Lobo on 26/08/19.
//  Copyright © 2019 Copyisright. All rights reserved.
//

import UIKit
import AuthenticationServices

class ReadingListCoordinator {
    
    let pocket: PocketClient
    
    private var readingCoordinator: ReadingCoordinator?
    
    weak private var navigable: Navigable?
    
    init(pocket: PocketClient) {
        self.pocket = pocket
        _ = pocket.login().subscribe() // FIXME
    }
    
    func start(navigable: Navigable) {
        self.navigable = navigable
        ReadingListRouter().navigate(navigable: navigable, toReadingList: create())
    }
    
    private func create() -> ReadingListViewController {
        let repository = ReadingListRepository(client: pocket)
        
        let viewModel = ReadingListViewModel()
        let model = ReadingListModel(repository: repository, presentation: viewModel)
        let view = ReadingListViewController(useCase: model, viewModel: viewModel)
        
        view.navigationDelegate = self
        
        return view
    }
    
}

extension ReadingListCoordinator: ReadingListNavigationDelegate {
    
    func navigate(to reading: Reading) {
        let readingCoordinator = ReadingCoordinator(reading: reading)
        
        guard let navigable = self.navigable else {
            return
        }
        
        self.readingCoordinator = readingCoordinator // Retain
        
        readingCoordinator.start(navigable: navigable)
    }
    
}
