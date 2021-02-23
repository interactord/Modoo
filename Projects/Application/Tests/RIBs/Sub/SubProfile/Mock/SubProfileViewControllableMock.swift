import RIBs
import RxRelay
import RxSwift
import UIKit
@testable import Application

// MARK: - SubProfileViewControllableMock

class SubProfileViewControllableMock: ViewControllableMock, SubProfilePresentable {
  var listener: SubProfilePresentableListener?

}

// MARK: SubProfileViewControllable

extension SubProfileViewControllableMock: SubProfileViewControllable {

}
