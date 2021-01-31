import RIBs
import RxSwift
import UIKit

protocol OnboardPresentableListener: AnyObject {
}

final class OnboardViewController: UITabBarController, OnboardPresentable, OnboardViewControllable {
  weak var listener: OnboardPresentableListener?

  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = .green
  }
}
