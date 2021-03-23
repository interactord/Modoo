import Nimble
import Quick

@testable import Application

class CommentViewControllerSpec: QuickSpec {
  override func spec() {
    // swiftlint:disable implicitly_unwrapped_optional
    var viewController: CommentViewController!
    // swiftlint:disable implicitly_unwrapped_optional
    var interactor: CommentInteractor!

    beforeEach {
      viewController = CommentViewController(node: .init())
      let state = CommentDisplayModel.State.defaultValue()
      interactor = CommentInteractor(
        presenter: viewController,
        initialState: state,
        commentUseCase: FirebaseCommentUseCaseMock())
      interactor.isStubEnabled = true
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

      context("백버튼을 누를 경우") {
        beforeEach {
          viewController.node.header.backButtonNode.sendActions(forControlEvents: .touchUpInside, with: .none)
        }

        it("interactor의 액션 login으로 전달이 된다") {
          expect(interactor.stub.actions.last) == CommentDisplayModel.Action.back
        }
      }
    }
  }
}
