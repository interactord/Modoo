import UIKit

UIApplicationMain(
  CommandLine.argc,
  CommandLine.unsafeArgv,
  NSStringFromClass(UIApplication.self),
  NSStringFromClass(NSClassFromString("ApplicationTest.TestAppDelegate") ?? AppDelegate.self)
)
