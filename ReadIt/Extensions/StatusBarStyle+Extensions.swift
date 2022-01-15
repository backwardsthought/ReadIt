//
//  UIStatusBarStyle+Extensions.swift
//  ReadIt
//
//  Created by Felipe Lobo on 26/08/19.
//  Copyright © 2019 Copyisright. All rights reserved.
//

import UIKit

extension UIStatusBarStyle {
	
	static func applyDarkContentIfNeeded(_ view: UIViewController) -> UIStatusBarStyle {
		if #available(iOS 13.0, *) {
			if view.traitCollection.userInterfaceStyle == .light {
				return .darkContent
			}
		}
		return .lightContent
	}
	
}
