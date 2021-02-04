import AsyncDisplayKit
import RIBs
import RxSwift
import UIKit

// MARK: - RegisterPresentableListener

protocol RegisterPresentableListener: AnyObject {
  func joinAction()
  func signUpAction()
}

// MARK: - RegisterViewController

final class RegisterViewController: ASDKViewController<RegisterContainerNode>, RegisterPresentable {

  // MARK: Lifecycle

  override init() {
    super.init(node: .init())
  }

  deinit {
    print("RegisterViewController deinit...")
  }

  @available(*, unavailable)
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  // MARK: Internal

  weak var listener: RegisterPresentableListener?

  override func viewDidLoad() {
    super.viewDidLoad()

    node.signUpButton.addTarget(self, action: #selector(onJoin), forControlEvents: .touchUpInside)
    node.alreadyHaveAccountButton.addTarget(self, action: #selector(onSignUp), forControlEvents: .touchUpInside)
  }

  @objc
  func onSignUp(sender: Any) {
    listener?.signUpAction()
  }

  @objc
  func onJoin(sender: Any) {
    listener?.joinAction()
  }
}

// MARK: RegisterViewControllable

extension RegisterViewController: RegisterViewControllable {
}
