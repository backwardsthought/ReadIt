//
//  ReadingListCoordinator.swift
//  ReadIt
//
//  Created by Felipe Lobo on 26/08/19.
//  Copyright © 2019 Copyisright. All rights reserved.
//

class ReadingListRouter {
    
    func navigate(navigable: Navigable, toReadingList view: View) {
        navigable.navigateTo(view: view, animated: false)
    }
    
}
