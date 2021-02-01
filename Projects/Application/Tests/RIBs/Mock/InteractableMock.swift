import RIBs
import RxRelay
import RxSwift

class InteractableMock: Interactable {

  // MARK: Lifecycle

  init() {}

  // MARK: Internal

  var isActiveSetCallCount = 0
  var isActiveStreamSubjectSetCallCount = 0
  // MARK: Function Handlers

  var activateHandler: (() -> Void)?
  var activateCallCount = 0
  var deactivateHandler: (() -> Void)?
  var deactivateCallCount = 0

  // MARK: Variables

  var isActive = false {
    didSet { isActiveSetCallCount += 1 }
  }

  var isActiveStreamSubject = PublishSubject<Bool>() {
    didSet { isActiveStreamSubjectSetCallCount += 1 }
  }

  var isActiveStream: Observable<Bool> { isActiveStreamSubject }

  func activate() {
    activateCallCount += 1
    activateHandler?()
  }

  func deactivate() {
    deactivateCallCount += 1
    deactivateHandler?()
  }
}
