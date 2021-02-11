import AsyncDisplayKit
import Firebase
import RIBs
import UIKit

class AppDelegate: UIResponder, UIApplicationDelegate {

  // MARK: Internal

  var window: UIWindow?
  var compositeRoot = CompositeRoot()

  func application(_: UIApplication, didFinishLaunchingWithOptions _: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
    FirebaseApp.configure()

    let window = UIWindow()
    let appComponent = compositeRoot.appComponent
    let launchRouter = RootBuilder(dependency: appComponent).build()
    launchRouter.launch(from: window)

    self.window = window
    self.launchRouter = launchRouter

    return true
  }

  // MARK: Private

  private var launchRouter: LaunchRouting?
}
