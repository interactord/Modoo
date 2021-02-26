import RxSwift
import UIKit

// MARK: - YPPostMediaPickerUseCase

final class YPPostMediaPickerUseCase {

  let core = YPMediaPicker()

}

// MARK: PostMediaPickerUseCase

extension YPPostMediaPickerUseCase: PostMediaPickerUseCase {
  func load(viewController: UIViewController) -> Observable<UIImage> {
    .create { [weak self] observer in
      guard let self = self else {
        observer.onCompleted()
        return Disposables.create()
      }

      self.core.picker.modalPresentationStyle = .fullScreen
      viewController.present(self.core.picker, animated: true)

      self.core.picker.didFinishPicking { items, _ in
        self.core.picker.dismiss(animated: false)

        if let image = items.singlePhoto?.image {
          observer.onNext(image)
        }

        observer.onCompleted()
      }

      return Disposables.create {
        self.core.picker.dismiss(animated: false)
      }
    }
  }
}
