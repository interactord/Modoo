@testable import Application
import UIKit
import RIBs
import RxSwift
import RxRelay

class RootViewControllableMock: RootViewControllable, RootPresentable {

	// MARK: Variables
	var uiViewControllerCallCount = 0
	var uiviewController = UIViewController() {
		didSet {
			uiViewControllerCallCount += 1
		}
	}
	var listener: RootPresentableListener?

	// MARK: Function Handler
	var failedLoginHandler: (() -> Void)?
	var failedLoginCallCount = 0

	init() {
	}

	func failedLogin() {
		failedLoginCallCount += 1
		failedLoginHandler?()
	}

  func present(viewController: ViewControllable) {
  }

  func dismiss(viewController: ViewControllable) {
  }

}
