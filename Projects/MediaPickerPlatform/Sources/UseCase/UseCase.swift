import RxSwift
import UIKit

import Domain

public final class UseCase: Domain.MediaPickerUseCase {

  // MARK: Lifecycle

  public init() {
  }

  // MARK: Public

  public func selectImage(targetViewController: UIViewController?, source: UIImagePickerController.SourceType, allowsEditing: Bool) -> Observable<(UIImage?, UIImage?)> {
    mediaPicker.selectImage(targetViewController: targetViewController, source: source, allowsEditing: allowsEditing)
  }

  // MARK: Internal

  let mediaPicker = MediaPicker()

}
