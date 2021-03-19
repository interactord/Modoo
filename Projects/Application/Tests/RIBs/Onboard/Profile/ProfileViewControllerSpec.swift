import Nimble
import Quick
import RxSwift
@testable import Application

class ProfileViewControllerSpec: QuickSpec {
  override func spec() {
    // swiftlint:disable implicitly_unwrapped_optional
    var viewController: ProfileViewController!
    // swiftlint:disable implicitly_unwrapped_optional
    var interactor: ProfileInteractor!
    // swiftlint:disable implicitly_unwrapped_optional
    var userUseCase: FirebaseUserUseCaseMock!
    // swiftlint:disable implicitly_unwrapped_optional
    var postUseCase: FirebasePostUseCaseMock!

    beforeEach {
      viewController = ProfileViewController(node: .init())
      let state = ProfileDisplayModel.State.defaultValue()
      userUseCase = FirebaseUserUseCaseMock()
      postUseCase = FirebasePostUseCaseMock()
      interactor = ProfileInteractor(
        presenter: viewController,
        initialState: state,
        userUseCase: userUseCase,
        postUseCase: postUseCase)
      interactor.isStubEnabled = true
      viewController.listener = interactor
    }
    afterEach {
      viewController = nil
      interactor = nil
      userUseCase = nil
      postUseCase = nil
    }

    describe("화면 로드가 완료되면") {
      beforeEach {
        viewController.loadView()
        viewController.viewDidLoad()
        viewController.viewDidAppear(false)
        viewController.viewDidLayoutSubviews()
      }

      it("interactor의 액션 load로 전달된다") {
        expect(interactor.stub.actions.last) == ProfileDisplayModel.Action.load
      }
    }

    context("더보기 버튼을 탭 했을 경우") {
      beforeEach {
        viewController.node.headerNode.moreButton.sendActions(forControlEvents: [.touchUpInside], with: .none)
      }

      it("interactor의 액션 logout으로 전달된다") {
        expect(interactor.stub.actions.last) == ProfileDisplayModel.Action.logout
      }
    }
  }
}
