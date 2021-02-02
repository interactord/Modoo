import UIKit

import RIBs
import RxRelay
import RxSwift

@testable import Application

// MARK: - RegisterViewControllableMock

class RegisterViewControllableMock: ViewControllableMock, RegisterPresentable {
  // MARK: Variables

  var listener: RegisterPresentableListener?
}

// MARK: RegisterViewControllable

extension RegisterViewControllableMock: RegisterViewControllable {}
