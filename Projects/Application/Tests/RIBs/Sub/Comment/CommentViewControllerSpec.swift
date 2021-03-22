import Nimble
import Quick

@testable import Application

class CommentViewControllerSpec: QuickSpec {
  override func spec() {
    // swiftlint:disable implicitly_unwrapped_optional
    var viewController: CommentViewController!

    beforeEach {
      viewController = CommentViewController()
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
