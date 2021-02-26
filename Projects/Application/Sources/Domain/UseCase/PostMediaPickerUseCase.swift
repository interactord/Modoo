import RxSwift
import UIKit

protocol PostMediaPickerUseCase {
  func load(viewController: UIViewController) -> Observable<UIImage>
}
