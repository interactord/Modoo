import Nimble
import Quick

@testable import Application

class FeedViewControllerSpec: QuickSpec {
  override func spec() {
    // swiftlint:disable implicitly_unwrapped_optional
    var viewController: FeedViewController!

    beforeEach {
      viewController = FeedViewController(node: .init())
    }
    afterEach {
      viewController = nil
    }

    describe("화면 로드가 완료되면") {
      beforeEach {
        viewController.loadView()
        viewController.viewDidLoad()
      }

      it("ing...") {
        expect(viewController).toNot(beNil())
      }
    }
  }
}
