import UIKit

import RIBs

class ViewControllableMock: ViewControllable {
  var uiViewControllerCallCount = 0

  var uiviewController = UIViewController() {
    didSet {
      uiViewControllerCallCount += 1
    }
  }
}
