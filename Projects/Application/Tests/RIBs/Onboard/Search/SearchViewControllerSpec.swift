import Nimble
import Quick
@testable import Application

class SearchViewControllerSpec: QuickSpec {
  override func spec() {
    // swiftlint:disable implicitly_unwrapped_optional
    var viewController: SearchViewController!

    beforeEach {
      viewController = SearchViewController()
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
