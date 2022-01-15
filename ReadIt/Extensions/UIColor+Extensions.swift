//
//  UIColor+Extensions.swift
//  ReadIt
//
//  Created by Felipe Lobo on 26/08/19.
//  Copyright © 2019 Copyisright. All rights reserved.
//

import UIKit

extension UIColor {

	static var systemFill: UIColor = UIColor(dynamicProvider: { $0.userInterfaceStyle == .light ? .black : .white })
	
}
