//
//  UINavigationController.swift
//  ReadIt
//
//  Created by Felipe Lobo on 26/08/19.
//  Copyright © 2019 Copyisright. All rights reserved.
//

import UIKit

extension UINavigationController: Navigable {
    
    func navigateTo(view: View, animated: Bool) {
        pushViewController(view, animated: animated)
    }
    
    func navigateBack(animated: Bool) {
        popViewController(animated: animated)
    }
    
}
