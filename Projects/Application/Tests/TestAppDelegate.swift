import UIKit
@testable import Application

final class TestAppDelegate: NSObject, UIApplicationDelegate {
  var window: UIWindow?
  var compositeRoot = CompositeRoot()
}
