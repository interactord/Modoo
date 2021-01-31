import UIKit

import RIBs

class ViewControllableMock: ViewControllable {
	// MARK: Variables
	var uiViewControllerCallCount = 0
	var uiviewController = UIViewController() {
		didSet {
			uiViewControllerCallCount += 1
		}
	}
}
