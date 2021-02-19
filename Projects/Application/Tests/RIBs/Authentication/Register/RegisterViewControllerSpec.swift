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
    let photoImage = UIImage()

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
          expect(interactor.stub.actions.last) == RegisterPresentableAction.login
        }
      }

//      context("사용자가 사진업로드 버튼을 입력할 경우") {
//        beforeEach {
//          viewController.node.registerFormNode.plusButtonNode.sendActions(forControlEvents: .touchUpInside, with: .none)
//        }
//
//        context("이미지 엘범에서 사진을 선택할 경우") {
//          beforeEach {
//            useCase.platform.imagePickerController(
//              UIImagePickerController(), didFinishPickingMediaWithInfo: [
//                .originalImage: photoImage as Any,
//                .editedImage: UIImage() as Any,
//              ])
//          }
//
//          it("사진업로드 버튼이 선택된 이미지로 변경된다") {
//            expect(viewController.node.registerFormNode.plusButtonNode.image(for: .normal)) === photoImage
//          }
//
//          it("interactor의 액션 사진으로 선택된 사진이 전달이 된다") {
//            expect(interactor.stub.actions.last) == RegisterPresentableAction.photo(photoImage)
//          }
//        }
//
//        context("이미지 앨범을 취소한 경우") {
//          beforeEach {
//            useCase.platform.imagePickerControllerDidCancel(UIImagePickerController())
//          }
//
//          it("interactor의 액션 사진으로 전달하지 않는다") {
//            expect(interactor.stub.actions.last) != RegisterPresentableAction.photo(photoImage)
//          }
//        }
//      }
    }
  }
}
