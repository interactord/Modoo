import Nimble
import Quick
import RxSwift
import UIKit

@testable import MediaPickerPlatform

class UseCaseSpec: QuickSpec {

  override func spec() {
    // swiftlint:disable implicitly_unwrapped_optional
    var useCase: UseCase!
    // swiftlint:disable implicitly_unwrapped_optional
    var viewController: UIViewController!
    // swiftlint:disable implicitly_unwrapped_optional
    var disposeBag: DisposeBag!
    // swiftlint:disable implicitly_unwrapped_optional
    var picker: UIImagePickerController!

    var nextCallCount = 0
    var completedCallCount = 0

    beforeEach {
      useCase = UseCase()
      viewController = UIViewController()
      disposeBag = DisposeBag()
      picker = UIImagePickerController()
    }
    afterEach {
      useCase = nil
      viewController = nil
      disposeBag = nil
      picker = nil
      nextCallCount = 0
      completedCallCount = 0
    }

    describe("UseCase selectImage 테스트") {

      context("Rx 이벤트 연결 후") {
        beforeEach {
          useCase
            .selectImage(targetViewController: viewController, source: .photoLibrary, allowsEditing: false)
            .subscribe(
              onNext: { _ in
                nextCallCount += 1
              },
              onError: { _ in },
              onCompleted: {
                completedCallCount += 1
              })
            .disposed(by: disposeBag)
        }

        context("사용자가 이미지피커 컨트롤러에서 사진을 클릭 할 경우") {
          beforeEach {
            useCase.mediaPicker.imagePickerController(
              picker,
              didFinishPickingMediaWithInfo: [
                .originalImage: UIImage() as Any,
                .editedImage: "" as Any,
              ])
          }

          context("사용자가 이미지를 선택한 경우") {

            it("nextCallCount가 1이된다") {
              expect(nextCallCount).toEventually(equal(1), timeout: .milliseconds(300))
            }

            it("completedCallCount는 1이 된다") {
              expect(completedCallCount).toEventually(equal(1), timeout: .milliseconds(300))
            }
          }
        }

        context("사용자가 이미지를 취소한 경우") {
          beforeEach {
            useCase.mediaPicker.imagePickerControllerDidCancel(picker)
          }

          it("nextCallCount가 0이된다") {
            expect(nextCallCount).toEventually(equal(0), timeout: .milliseconds(300))
          }

          it("completedCallCount는 1이 된다") {
            expect(completedCallCount).toEventually(equal(1), timeout: .milliseconds(300))
          }
        }
      }
    }
  }
}
