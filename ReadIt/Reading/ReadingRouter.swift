//
//  ReadingRouter.swift
//  ReadIt
//
//  Created by Felipe Lobo on 26/08/19.
//  Copyright © 2019 Copyisright. All rights reserved.
//

class ReadingRouter {
    
    func navigate(navigable: Navigable, toReading view: View) {
        navigable.navigateTo(view: view, animated: true)
    }
    
}
