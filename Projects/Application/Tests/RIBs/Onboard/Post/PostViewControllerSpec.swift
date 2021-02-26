import Nimble
import Quick
@testable import Application

class PostViewControllerSpec: QuickSpec {
  override func spec() {
    // swiftlint:disable implicitly_unwrapped_optional
    var viewController: PostViewController!
    // swiftlint:disable implicitly_unwrapped_optional
    var interactor: PostInteractor!

    beforeEach {
      viewController = PostViewController(node: .init())
      interactor = PostInteractor(
        presenter: viewController,
        initialState: .initialState())
      interactor.isStubEnabled = true
      viewController.listener = nil
    }
    afterEach {
      viewController = nil
      interactor = nil
    }

    describe("화면 로드가 완료되면") {
      beforeEach {
        viewController.listener = interactor
        viewController.loadView()
        viewController.viewDidLoad()
      }

      context("취소 버튼을 눌렀을 경우") {
        beforeEach {
          viewController.node.headerNode.cancelButton.sendActions(forControlEvents: .touchUpInside, with: .none)
        }

        it("cancel 액션이 호출된다") {
          expect(interactor.stub.actions.last) == PostPresentableAction.cancel
        }
      }
    }
  }
}
