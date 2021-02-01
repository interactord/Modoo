import RIBs
import RxRelay
import RxSwift
import UIKit
@testable import Application

// MARK: - LoginViewControllableMock

class LoginViewControllableMock: ViewControllableMock, LoginPresentable {
  // MARK: Variables

  var listener: LoginPresentableListener?
}

// MARK: LoginViewControllable

extension LoginViewControllableMock: LoginViewControllable {}
