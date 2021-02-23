import RIBs
@testable import Application

// MARK: - SubProfileBuildableMock

class SubProfileBuildableMock: Builder<SubProfileDependency> {

  init() {
    super.init(dependency: SubProfileDependencyMock())
  }

}

// MARK: SubProfileBuildable

extension SubProfileBuildableMock: SubProfileBuildable {
  func build(withListener listener: SubProfileListener) -> SubProfileRouting {
    _ = SubProfileComponent(dependency: dependency)
    let viewController = SubProfileViewController()
    let interactor = SubProfileInteractor(presenter: viewController)
    interactor.listener = listener

    return SubProfileRouter(
      interactor: interactor,
      viewController: viewController)
  }

}
