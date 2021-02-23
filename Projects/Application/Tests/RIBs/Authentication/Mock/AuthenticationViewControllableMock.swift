import UIKit

import RIBs
import RxRelay
import RxSwift

@testable import Application

// MARK: - AuthenticationViewControllableMock

class AuthenticationViewControllableMock: ViewControllableMock, AuthenticationPresentable {

  var setRootCallCount = 0
  var setRootHandler: (() -> Void)?
  var clearChildViewControllersCallCount = 0
  var clearChildViewControllersHandler: (() -> Void)?
  var popToRootViewControllableCallCount = 0
  var popToRootViewControllableHandler: (() -> Void)?

  var listener: AuthenticationPresentableListener?
}

// MARK: AuthenticationViewControllable

extension AuthenticationViewControllableMock: AuthenticationViewControllable {

  func setRoot(viewControllable: ViewControllable, animated: Bool) {
    viewControllers = 1
    setRootCallCount += 1
    setRootHandler?()
  }

  func popToRootViewControllable(animated: Bool) {
    viewControllers = 1
    popToRootViewControllableCallCount += 1
    popToRootViewControllableHandler?()
  }
}
