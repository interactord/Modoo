import UIKit

import RIBs
import RxRelay
import RxSwift

@testable import Application

// MARK: - AuthenticationViewControllerMock

class AuthenticationViewControllerMock: ViewControllableMock, AuthenticationPresentable {
  var listener: AuthenticationPresentableListener?
}

// MARK: AuthenticationViewControllable

extension AuthenticationViewControllerMock: AuthenticationViewControllable {}
