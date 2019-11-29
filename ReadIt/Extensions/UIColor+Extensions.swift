import UIKit

extension UIColor {
	
	static var dynamicSystem: UIColor = {
		if #available(iOS 13.0, *) {
			return UIColor { (trait: UITraitCollection) -> UIColor in
				if trait.userInterfaceStyle == .light {
					return .white
				}
				return .black
			}
		}
		return .white
	}()
	
	static var invertedColors: UIColor = {
		if #available(iOS 13.0, *) {
			return UIColor { (trait: UITraitCollection) -> UIColor in
				if trait.userInterfaceStyle == .light {
					return .black
				}
				return .white
			}
		}
		return .black
	}()
	
}
