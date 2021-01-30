import RIBs
import UIKit

class AppDelegate: UIResponder, UIApplicationDelegate {
  var window: UIWindow?
  private var launchRouter: LaunchRouting?

  func application(_: UIApplication, didFinishLaunchingWithOptions _: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
    let window = UIWindow()
    let launchRouter = RootBuilder(dependency: AppComponent()).build()
    launchRouter.launch(from: window)

    self.window = window
    self.launchRouter = launchRouter

    return true
  }
}
