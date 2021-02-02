import RIBs
import RxRelay
import RxSwift

class InteractorMock: Interactable {

  // MARK: Lifecycle

  init() {}

  // MARK: Internal

  var isActive: Bool { active.value }
  var isActiveStream: Observable<Bool> { active.asObservable() }

  func activate() {
    active.accept(true)
  }

  func deactivate() {
    active.accept(false)
  }

  // MARK: Private

  private let active = BehaviorRelay<Bool>(value: false)
}
