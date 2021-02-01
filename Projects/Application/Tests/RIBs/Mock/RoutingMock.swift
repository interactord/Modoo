import RIBs
import RxRelay
import RxSwift

class RoutingMock: ViewableRouting, Routing {

  // MARK: Lifecycle

  init(
    interactable: Interactable,
    viewControllable: ViewControllable)
  {
    self.interactable = interactable
    self.viewControllable = viewControllable
  }

  // MARK: Internal

  var viewControllable: ViewControllable
  var interactableSetCallCount = 0
  var childrenSetCallCount = 0
  var lifecycleSubjectSetCallCount = 0
  var loadHandler: (() -> Void)?
  var loadCallCount = 0
  var attachChildHandler: ((_ child: Routing) -> Void)?
  var attachChildCallCount = 0
  var detachChildHandler: ((_ child: Routing) -> Void)?
  var detachChildCallCount: Int = 0

  var interactable: Interactable {
    didSet { interactableSetCallCount += 1 }
  }

  var children = [Routing]() {
    didSet { childrenSetCallCount += 1 }
  }

  var lifecycleSubject = PublishSubject<RouterLifecycle>() {
    didSet { lifecycleSubjectSetCallCount += 1 }
  }

  var lifecycle: Observable<RouterLifecycle> { lifecycleSubject }

  func load() {
    loadCallCount += 1
    loadHandler?()
  }

  func attachChild(_ child: Routing) {
    attachChildCallCount += 1
    attachChildHandler?(child)
  }

  func detachChild(_ child: Routing) {
    detachChildCallCount += 1
    detachChildHandler?(child)
  }
}
