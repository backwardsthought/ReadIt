import UIKit

extension UIColor {

	static var systemFill: UIColor = {
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
