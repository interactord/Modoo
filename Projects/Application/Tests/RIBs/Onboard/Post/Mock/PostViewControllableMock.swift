import RIBs
import RxRelay
import RxSwift
import UIKit
@testable import Application

// MARK: - PostViewControllableMock

class PostViewControllableMock: ViewControllableMock, PostPresentable {
  var listener: PostPresentableListener?

}

// MARK: PostViewControllable

extension PostViewControllableMock: PostViewControllable {

}
