import RIBs
@testable import Application

// MARK: - OnboardBuildableMock

class OnboardBuildableMock: Builder<OnboardDependency> {

  // MARK: Lifecycle

  init() {
    super.init(dependency: component)
  }

  // MARK: Private

  private let component = RootComponent(
    dependency: AppComponent(),
    rootViewController: RootViewController())

}

// MARK: OnboardBuildable

extension OnboardBuildableMock: OnboardBuildable {
  func build(withListener listener: OnboardListener) -> OnboardRouting {
    _ = OnboardComponent(dependency: dependency)

    let viewController = OnboardViewController()
    let interactor = OnboardInteractor(presenter: viewController)
    interactor.listener = listener
    return OnboardRouter(interactor: interactor, viewController: viewController)
  }
}
