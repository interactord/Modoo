import RIBs
import RxSwift
import RxRelay

class RoutingMock: ViewableRouting, Routing {
	// MARK: Variables
	var viewControllable: ViewControllable
	var interactable: Interactable {
		didSet { interactableSetCallCount += 1 }
	}
	var interactableSetCallCount = 0
	var children = [Routing]() {
		didSet { childrenSetCallCount += 1 }
	}
	var childrenSetCallCount = 0
	var lifecycleSubject = PublishSubject<RouterLifecycle>() {
		didSet { lifecycleSubjectSetCallCount += 1 }
	}
	var lifecycleSubjectSetCallCount = 0
	var lifecycle: Observable<RouterLifecycle> { lifecycleSubject }

	// MARK: Function Handlers
	var loadHandler: (() -> Void)?
	var loadCallCount = 0
	var attachChildHandler: ((_ child: Routing) -> Void)?
	var attachChildCallCount = 0
	var detachChildHandler: ((_ child: Routing) -> Void)?
	var detachChildCallCount: Int = 0

	init(interactable: Interactable,
			 viewControllable: ViewControllable) {
		self.interactable = interactable
		self.viewControllable = viewControllable
	}

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
