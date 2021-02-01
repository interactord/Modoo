import RIBs
import RxRelay
import RxSwift
import UIKit
@testable import Application

// MARK: - RootViewControllableMock

class RootViewControllableMock: ViewControllableMock, RootPresentable {
  // MARK: Variables

  var listener: RootPresentableListener?

  // MARK: Function Handler

  var presentHandler: (() -> Void)?
  var presentCallCount: Int = 0
  var dismissHandler: (() -> Void)?
  var dismissCallCount: Int = 0
}

// MARK: RootViewControllable

extension RootViewControllableMock: RootViewControllable {
  func present(viewController _: ViewControllable) {
    presentCallCount += 1
    presentHandler?()
  }

  func dismiss(viewController _: ViewControllable) {
    dismissCallCount += 1
    dismissHandler?()
  }
}
