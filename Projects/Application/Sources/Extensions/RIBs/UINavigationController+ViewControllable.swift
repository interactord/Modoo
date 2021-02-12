import RIBs
import UIKit

extension UINavigationController: ViewControllable {

  // MARK: Lifecycle

  public convenience init(image: UIImage? = nil, unselectedImage: UIImage? = nil, root: ViewControllable) {
    self.init(rootViewController: root.uiviewController)

    tabBarItem.image = unselectedImage
    tabBarItem.selectedImage = image
    navigationBar.tintColor = .black
  }

  // MARK: Public

  public var uiviewController: UIViewController { self }

}
