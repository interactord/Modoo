@testable import Application
import Quick
import Nimble

class RootInteractorSpec: QuickSpec {
	override func spec() {
		var interactor: RootInteractor!
		var viewController: RootViewControllableMock!
		var router: RootRoutingMock!

		beforeEach {
			viewController = RootViewControllableMock()
			interactor = RootInteractor(presenter: viewController)
			router = RootRoutingMock(interactable: interactor, viewControllable: viewController)
			interactor.router = router
			interactor.activate()
			print("beforeEach")
		}

		describe("RootInteractor") {
			context("로그인이 되었을 경우") {
				it("attachChildCallCount가 1이 되어야한다") {
					interactor.didLogin()
					expect(router.attachChildCallCount) == 1
				}
			}

			context("deactivate 될 경우") {
				it("cleanup 메서드가 호출이 된다") {
					interactor.deactivate()
					expect(router.cleanupViewCallCount) == 1
				}
			}
		}

	}
}
