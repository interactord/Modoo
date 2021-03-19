import Foundation
import RxSwift

@testable import Application

// MARK: - ListenerBindableMock

final class ListenerBindableMock {
  var disposeBag = DisposeBag()

  var bindActionCallCount = 0
  var bindActionHandler: (() -> Void)?

  var bindStateCallCount = 0
  var bindStateHanlder: (() -> Void)?
}

// MARK: ListenerBindable

extension ListenerBindableMock: ListenerBindable {
  func bindAction(listener: String) {
    bindActionCallCount += 1
    bindActionHandler?()
  }

  func bindState(listener: String) {
    bindStateCallCount += 1
    bindStateHanlder?()
  }
}
