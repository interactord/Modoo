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
    var userUseCaseMock: FirebaseUserUseCaseMock!

    beforeEach {
      viewController = ProfileViewController(node: .init())
      let state = ProfileDisplayModel.State.initialState()
      userUseCaseMock = FirebaseUserUseCaseMock()
      interactor = ProfileInteractor(
        presenter: viewController,
        initialState: state,
        userUseCase: userUseCaseMock)
      interactor.isStubEnabled = true
      viewController.listener = interactor
    }
    afterEach {
      viewController = nil
      interactor = nil
      userUseCaseMock = nil
    }

    describe("화면 로드가 완료되면") {
      beforeEach {
        viewController.loadView()
        viewController.viewDidLoad()
        viewController.viewDidAppear(false)
        viewController.viewDidLayoutSubviews()
      }

      it("interactor의 액션 load로 전달된다") {
        expect(interactor.stub.actions.last) == ProfilePresentableAction.load
      }
    }

    context("더보기 버튼을 탭 했을 경우") {
      beforeEach {
        viewController.node.headerNode.moreButton.sendActions(forControlEvents: [.touchUpInside], with: .none)
      }

      it("interactor의 액션 logout으로 전달된다") {
        expect(interactor.stub.actions.last) == ProfilePresentableAction.logout
      }
    }
  }
}
