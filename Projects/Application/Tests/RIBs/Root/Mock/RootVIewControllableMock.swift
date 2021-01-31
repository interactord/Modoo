@testable import Application
import UIKit
import RIBs
import RxSwift
import RxRelay

class RootViewControllableMock: ViewControllableMock, RootPresentable {

	// MARK: Variables
	var listener: RootPresentableListener?

	override init() {
		super.init()
	}
}

// MARK: - RootPresentable

extension RootViewControllableMock {
	func present(viewController: ViewControllable) {
	}

	func dismiss(viewController: ViewControllable) {
	}
}
