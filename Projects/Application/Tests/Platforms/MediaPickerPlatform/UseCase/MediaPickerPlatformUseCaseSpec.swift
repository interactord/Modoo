import Nimble
import Quick

import RxSwift
import UIKit

@testable import Application

class MediaPickerPlatformUseCaseSpec: QuickSpec {
  override func spec() {
    // swiftlint:disable implicitly_unwrapped_optional
    var picker: UIImagePickerController!
    // swiftlint:disable implicitly_unwrapped_optional
    var useCase: UIMediaPickerPlatformUseCase!
    // swiftlint:disable implicitly_unwrapped_optional
    var disposeBag: DisposeBag!

    var nextCallCount = 0
    var completedCallCount = 0

    beforeEach {
      useCase = UIMediaPickerPlatformUseCase()
      picker = UIImagePickerController()
      disposeBag = DisposeBag()
    }
    afterEach {
      useCase = nil
      picker = nil
      disposeBag = nil
      nextCallCount = 0
      completedCallCount = 0
    }

    describe("MediaPickerPlatformUseCase") {

      context("selectImage 이벤트를 구독하고") {

        beforeEach {
          useCase
            .selectImage(targetViewController: picker, source: .photoLibrary, allowsEditing: true)
            .subscribe(
              onNext: { _ in
                nextCallCount += 1
              },
              onCompleted: {
                completedCallCount += 1
              }).disposed(by: disposeBag)
        }

        context("이미지 피커에서 사용자가 사진을 선택 한 경우") {
          beforeEach {
            useCase.platform.imagePickerController(
              picker,
              didFinishPickingMediaWithInfo: [
                .originalImage: UIImage() as Any,
                .editedImage: UIImage() as Any,
              ])
          }

          it("onNext이벤트가 호출이 되어 nextCallCount가 1이 된다") {
            expect(nextCallCount).toEventually(equal(1), timeout: TestUtil.Const.timeout)
          }
          it("onCompleted이벤트가 호출이 되어 completedCallCount가 1이 된다") {
            expect(completedCallCount).toEventually(equal(1), timeout: TestUtil.Const.timeout)
          }
        }

        context("이미지 피커에서 사용자가 취소를 한 경우") {
          beforeEach {
            useCase.platform.imagePickerControllerDidCancel(picker)
          }

          it("onNext이벤트가 호출이 되지않아 nextCallCount가 0이 된다") {
            expect(nextCallCount).toEventually(equal(0), timeout: TestUtil.Const.timeout)
          }
          it("onCompleted이벤트가 호출이 되어 completedCallCount가 1이 된다") {
            expect(completedCallCount).toEventually(equal(1), timeout: TestUtil.Const.timeout)
          }
        }
      }
    }
  }
}
