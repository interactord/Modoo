import UIKit

class WindowMock: UIWindow {

  // MARK: Internal

  override var isKeyWindow: Bool { internalIsKeyWindow }
  override var rootViewController: UIViewController? {
    get { internalRootViewController }
    set { internalRootViewController = newValue }
  }

  override func makeKeyAndVisible() {
    internalIsKeyWindow = true
  }

  // MARK: Private

  // MARK: Variables

  private var internalIsKeyWindow: Bool = false
  private var internalRootViewController: UIViewController?
}
