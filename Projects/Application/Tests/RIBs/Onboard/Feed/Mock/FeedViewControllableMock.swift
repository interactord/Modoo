import RIBs
import RxRelay
import RxSwift
import UIKit
@testable import Application

// MARK: - FeedViewControllableMock

class FeedViewControllableMock: ViewControllableMock, FeedPresentable {
  var listener: FeedPresentableListener?

}

// MARK: FeedViewControllable

extension FeedViewControllableMock: FeedViewControllable {

}
