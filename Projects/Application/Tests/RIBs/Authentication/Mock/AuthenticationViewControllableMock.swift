import UIKit

import RIBs
import RxRelay
import RxSwift

@testable import Application

// MARK: - AuthenticationViewControllableMock

class AuthenticationViewControllableMock: ViewControllableMock, AuthenticationPresentable {

  var listener: AuthenticationPresentableListener?
}

// MARK: AuthenticationViewControllable

extension AuthenticationViewControllableMock: AuthenticationViewControllable {
}
