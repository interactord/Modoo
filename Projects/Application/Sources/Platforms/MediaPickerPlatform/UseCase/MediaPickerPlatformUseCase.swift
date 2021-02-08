import RxSwift
import UIKit

final class MediaPickerPlatformUseCase: MediaPickerUseCase {

  // MARK: Lifecycle

  init() {
  }

  // MARK: Internal

  let platform = MediaPickerPlatform()

  func selectImage(targetViewController: UIViewController?, source: UIImagePickerController.SourceType, allowsEditing: Bool) -> Observable<(UIImage?, UIImage?)> {
    platform.selectImage(targetViewController: targetViewController, source: source, allowsEditing: allowsEditing)
  }

}
