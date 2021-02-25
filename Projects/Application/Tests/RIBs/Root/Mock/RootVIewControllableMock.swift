import RIBs
import RxRelay
import RxSwift
import UIKit
@testable import Application

// MARK: - RootViewControllableMock

class RootViewControllableMock: ViewControllableMock, RootPresentable {
  // MARK: Variables

  var listener: RootPresentableListener?
}

// MARK: RootViewControllable

extension RootViewControllableMock: RootViewControllable {
}
