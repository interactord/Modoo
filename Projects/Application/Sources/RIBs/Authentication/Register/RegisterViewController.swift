import AsyncDisplayKit
import RIBs
import RxSwift
import UIKit

// MARK: - RegisterPresentableListener

protocol RegisterPresentableListener: AnyObject {
}

// MARK: - RegisterViewController

final class RegisterViewController: ASDKViewController<RegisterContainerNode>, RegisterPresentable {

  // MARK: Lifecycle

  override init() {
    super.init(node: .init())
  }

  @available(*, unavailable)
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  deinit {
    print("RegisterViewController deinit...")
  }

  // MARK: Internal

  weak var listener: RegisterPresentableListener?

}

// MARK: RegisterViewControllable

extension RegisterViewController: RegisterViewControllable {
}
