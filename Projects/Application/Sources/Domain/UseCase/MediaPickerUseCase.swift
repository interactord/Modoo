import RxSwift
import UIKit

protocol MediaPickerUseCase {
  func selectImage(
    targetViewController: UIViewController?,
    source: UIImagePickerController.SourceType,
    allowsEditing: Bool) -> Observable<(UIImage?, UIImage?)>
}
