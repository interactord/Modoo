@testable import Application
import RIBs
import RxSwift
import RxRelay

class RootRoutingMock: RootRouting {
  // MARK: Variables
	var viewControllable: ViewControllable
	var interactable: Interactable { didSet { interactableSetCallCount += 1 } }
	var interactableSetCallCount = 0
	var children: [Routing] = [Routing]() { didSet { childrenSetCallCount += 1 } }
	var childrenSetCallCount = 0
	var lifecycleSubject: PublishSubject<RouterLifecycle> = PublishSubject<RouterLifecycle>() { didSet { lifecycleSubjectSetCallCount += 1 } }
	var lifecycleSubjectSetCallCount = 0
	var lifecycle: Observable<RouterLifecycle> { return lifecycleSubject }

	// MARK: Function Handlers
	var loadHandler: (() -> Void)?
	var loadCallCount: Int = -1
	var attachChildHandler: ((_ child: Routing) -> Void)?
	var attachChildCallCount: Int = -1
	var detachChildHandler: ((_ child: Routing) -> Void)?
	var detachChildCallCount: Int = -1

	var routeToFailAlertHandler: (() -> Void)?
	var routeToFailAlertCallCount: Int = 0

	init(interactable: Interactable,
	     viewControllable: ViewControllable) {
		self.interactable = interactable
		self.viewControllable = viewControllable
	}

	func load() {
		loadCallCount += 1
		loadHandler?()
	}

	func routeToFailAlert() {
		routeToFailAlertCallCount += 1
		routeToFailAlertHandler?()
	}

	func attachChild(_ child: Routing) {
		attachChildCallCount += 1
		attachChildHandler?(child)
	}

	func detachChild(_ child: Routing) {
		detachChildCallCount += 1
		detachChildHandler?(child)
	}

  func cleanupViews() {
//	  attachChildCallCount = 0
//	  detachChildCallCount = 0
  }

  func routeToLoggedIn() {
  }
}
