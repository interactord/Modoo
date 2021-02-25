import RIBs
import UIKit

// MARK: - NavigationController

final class NavigationController: UINavigationController, ViewControllable {

  // MARK: Lifecycle

  init(viewControllerType: ViewControllerType, image: UIImage? = nil, unselectedImage: UIImage? = nil, root: ViewControllable) {
    self.viewControllerType = viewControllerType

    super.init(rootViewController: root.uiviewController)

    tabBarItem.image = unselectedImage
    tabBarItem.selectedImage = image
    navigationBar.tintColor = .black
    self.viewControllerType = viewControllerType
  }

  @available(*, unavailable)
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  // MARK: Internal

  enum ViewControllerType {
    case feed
    case search
    case post
    case profile
  }

  var viewControllerType: ViewControllerType

  var uiviewController: UIViewController { self }
}
