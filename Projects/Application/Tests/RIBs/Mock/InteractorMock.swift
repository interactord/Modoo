import RIBs
import RxRelay
import RxSwift

class InteractorMock: Interactable {
	// MARK: Variables
	private let active = BehaviorRelay<Bool>(value: false)
	var isActive: Bool { active.value }
	var isActiveStream: Observable<Bool> { active.asObservable() }

	init() {
	}

	func activate() {
		active.accept(true)
	}

	func deactivate() {
		active.accept(false)
	}
}
