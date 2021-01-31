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
			interactor = RootInteractor.init(presenter: viewController)
			router = RootRoutingMock(interactable: interactor, viewControllable: viewController)
			router.load()
		}

		describe("RootInteractor") {
			context("when initial active") {
				router.interactable.activate()

				it("attachChildCallCount is zero") {
					expect(router.attachChildCallCount).to(equal(0))
				}

			}
		}
	}
}