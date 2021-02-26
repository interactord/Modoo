import RxSwift
import UIKit
@testable import Application

final class YPPostMediaPickerUseCaseMock: PostMediaPickerUseCase {
  var image: UIImage?

  func load(viewController: UIViewController) -> Observable<UIImage> {
    .create { [weak self] observer in
      guard let self = self else {
        observer.onCompleted()
        return Disposables.create()
      }

      if let image = self.image {
        observer.onNext(image)
      }
      observer.onCompleted()

      return Disposables.create()
    }
  }
}
