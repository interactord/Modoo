import RIBs
import RxRelay
import RxSwift
import UIKit

@testable import Application

// MARK: - SubFeedViewControllableMock

class SubFeedViewControllableMock: ViewControllableMock, SubFeedPresentable {
  var listener: SubFeedPresentableListener?

}

// MARK: SubFeedViewControllable

extension SubFeedViewControllableMock: SubFeedViewControllable {

}
