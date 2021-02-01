import RIBs
import UIKit

class AppDelegate: UIResponder, UIApplicationDelegate {

  // MARK: Internal

  var window: UIWindow?

  func application(_: UIApplication, didFinishLaunchingWithOptions _: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
    let window = UIWindow()
    let launchRouter = RootBuilder(dependency: AppComponent()).build()
    launchRouter.launch(from: window)

    self.window = window
    self.launchRouter = launchRouter

    return true
  }

  // MARK: Private

  private var launchRouter: LaunchRouting?

}
