import RIBs
import RxSwift
import RxRelay

class InteractableMock: Interactable {
	// MARK: Variables
	var isActive = false {
		didSet { isActiveSetCallCount += 1 }
	}
	var isActiveSetCallCount = 0
	var isActiveStreamSubject = PublishSubject<Bool>() {
		didSet { isActiveStreamSubjectSetCallCount += 1 }
	}
	var isActiveStreamSubjectSetCallCount = 0
	var isActiveStream: Observable<Bool> { isActiveStreamSubject }

	// MARK: Function Handlers
	var activateHandler: (() -> Void)?
	var activateCallCount = 0
	var deactivateHandler: (() -> Void)?
	var deactivateCallCount = 0

	init() {}

	func activate() {
		activateCallCount += 1
		activateHandler?()
	}

	func deactivate() {
		deactivateCallCount += 1
		deactivateHandler?()
	}
}
