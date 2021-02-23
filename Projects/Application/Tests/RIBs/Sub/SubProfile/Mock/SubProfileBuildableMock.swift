import RIBs
@testable import Application

// MARK: - SubProfileBuildableMock

class SubProfileBuildableMock: Builder<SubProfileDependency> {

  // MARK: Lifecycle

  init() {
    super.init(dependency: SubProfileDependencyMock())
  }

  // MARK: Fileprivate

  fileprivate var userUseCase: UserUseCase {
    FirebaseUserUseCase(
      authenticating: FirebaseAuthentication(),
      apiNetworking: FirebaseAPINetwork())
  }

}

// MARK: SubProfileBuildable

extension SubProfileBuildableMock: SubProfileBuildable {
  func build(withListener listener: SubProfileListener, uid: String) -> SubProfileRouting {
    _ = SubProfileComponent(dependency: dependency)
    let viewController = SubProfileViewController()
    let interactor = SubProfileInteractor(
      presenter: viewController,
      userUseCase: userUseCase,
      uid: uid)
    interactor.listener = listener

    return SubProfileRouter(
      interactor: interactor,
      viewController: viewController)
  }

}
