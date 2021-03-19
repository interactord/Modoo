import Nimble
import Quick
import UIKit

@testable import Application

class RegisterViewControllerSpec: QuickSpec {
  override func spec() {
    // swiftlint:disable implicitly_unwrapped_optional
    var viewController: RegisterViewController!
    // swiftlint:disable implicitly_unwrapped_optional
    var interactor: RegisterInteractor!
    // swiftlint:disable implicitly_unwrapped_optional
    var useCase: UIMediaPickerPlatformUseCase!
    // swiftlint:disable implicitly_unwrapped_optional
    var authenticationUseCase: AuthenticationUseCase!
//    let photoImage = UIImage()

    beforeEach {
      useCase = UIMediaPickerPlatformUseCase()
      viewController = RegisterViewController(mediaPickerUseCase: useCase)
      authenticationUseCase = FirebaseAuthenticationUseCase(
        authenticating: FirebaseAuthentication(),
        mediaUploading: FirebaseMediaUploader(),
        apiNetworking: FirebaseAPINetwork())
      let state = RegisterDisplayModel.State.initialState()
      interactor = RegisterInteractor(
        presenter: viewController,
        initialState: state,
        authenticationUseCase: authenticationUseCase)
      interactor.isStubEnabled = true
      viewController.listener = interactor
    }
    afterEach {
      viewController = nil
      interactor = nil
      useCase = nil
      authenticationUseCase = nil
    }

    describe("RegisterViewController 화면 노출 후") {
      beforeEach {
        viewController.loadView()
        viewController.viewDidLoad()
        viewController.viewDidLayoutSubviews()
      }

      context("로그인버튼을 누를 경우") {
        beforeEach {
          viewController.node.alreadyHaveAccountButtonNode.sendActions(forControlEvents: .touchUpInside, with: .none)
        }

        it("interactor의 액션 login으로 전달이 된다") {
          expect(interactor.stub.actions.last) == RegisterDisplayModel.Action.login
        }
      }
    }
  }
}
