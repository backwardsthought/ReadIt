//
//  Navigatable.swift
//  ReadIt
//
//  Created by Felipe Lobo on 26/08/19.
//  Copyright © 2019 Copyisright. All rights reserved.
//

protocol Navigable: class {
    
    func navigateTo(view: View, animated: Bool)
    
    func navigateBack(animated: Bool)
    
}
