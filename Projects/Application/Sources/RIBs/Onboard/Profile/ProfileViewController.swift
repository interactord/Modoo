import AsyncDisplayKit
import RIBs
import RxSwift
import UIKit

// MARK: - ProfilePresentableListener

protocol ProfilePresentableListener: AnyObject {
}

// MARK: - ProfileViewController

final class ProfileViewController: ASDKViewController<ProfileContainerNode>, ProfilePresentable, ProfileViewControllable {

  // MARK: Lifecycle

  override init() {
    super.init(node: .init())
  }

  @available(*, unavailable)
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  deinit {
    print("ProfileViewController deinit...")
  }

  // MARK: Internal

  weak var listener: ProfilePresentableListener?
}
