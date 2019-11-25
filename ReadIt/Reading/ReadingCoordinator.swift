//
//  ReadingCoordinator.swift
//  ReadIt
//
//  Created by Felipe Lobo on 26/08/19.
//  Copyright © 2019 Copyisright. All rights reserved.
//

import UIKit

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
        
        return view
    }
    
}
