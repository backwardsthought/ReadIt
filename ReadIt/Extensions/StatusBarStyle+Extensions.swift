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
