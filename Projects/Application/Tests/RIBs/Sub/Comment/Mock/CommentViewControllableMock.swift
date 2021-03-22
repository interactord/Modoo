import RIBs
import RxRelay
import RxSwift
import UIKit

@testable import Application

// MARK: - CommentViewControllableMock

class CommentViewControllableMock: ViewControllableMock, CommentPresentable {
  var listener: CommentPresentableListener?

}

// MARK: CommentViewControllable

extension CommentViewControllableMock: CommentViewControllable {

}
