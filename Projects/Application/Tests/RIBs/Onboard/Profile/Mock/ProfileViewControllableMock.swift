import RIBs
import RxRelay
import RxSwift
import UIKit
@testable import Application


// MARK: - ProfileViewControllableMock

class ProfileViewControllableMock: ViewControllableMock, ProfilePresentable {
  var listener: ProfilePresentableListener?

}

// MARK: ProfileViewControllable

extension ProfileViewControllableMock: ProfileViewControllable {

}
