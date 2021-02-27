import Nimble
import Quick
@testable import Application

class PostViewControllerSpec: QuickSpec {
  override func spec() {
    // swiftlint:disable implicitly_unwrapped_optional
    var viewController: PostViewController!
    // swiftlint:disable implicitly_unwrapped_optional
    var interactor: PostInteractor!
    // swiftlint:disable implicitly_unwrapped_optional
    var postUseCase: FirebasePostUseCaseMock!
    // swiftlint:disable implicitly_unwrapped_optional
    var userUseCase: FirebaseUserUseCaseMock!

    beforeEach {
      viewController = PostViewController(node: .init())
      postUseCase = FirebasePostUseCaseMock()
      userUseCase = FirebaseUserUseCaseMock()
      interactor = PostInteractor(
        presenter: viewController,
        initialState: .initialState(),
        postUseCase: postUseCase,
        userUseCase: userUseCase)
      interactor.isStubEnabled = true
      viewController.listener = nil
    }
    afterEach {
      viewController = nil
      interactor = nil
      postUseCase = nil
      userUseCase = nil
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

      context("공유 버튼을 눌렀을 경우") {
        beforeEach {
          viewController.node.headerNode.shareButton.sendActions(forControlEvents: .touchUpInside, with: .none)
        }

        it("cancel 액션이 호출된다") {
          expect(interactor.stub.actions.last) == PostPresentableAction.share
        }
      }
    }
  }
}
