import RxSwift
import UIKit

public protocol MediaPickerUseCase {
  func selectImage(
    targetViewController: UIViewController?,
    source: UIImagePickerController.SourceType,
    allowsEditing: Bool) -> Observable<(UIImage?, UIImage?)>
}
