import Nimble
import Quick
import RxSwift
@testable import Application

class ProfileViewControllerSpec: QuickSpec {
  override func spec() {
    // swiftlint:disable implicitly_unwrapped_optional
    var viewController: ProfileViewController!

    beforeEach {
      viewController = ProfileViewController(node: .init())
    }
    afterEach {
      viewController = nil
    }

    describe("화면 로드가 완료되면") {
      beforeEach {
        viewController.loadView()
        viewController.viewDidLoad()
      }

      context("더미 아이템을 1개를 담을 경우") {
        beforeEach {
          viewController.items = Array(repeating: "A", count: 1)
        }
      }
    }
  }
}
