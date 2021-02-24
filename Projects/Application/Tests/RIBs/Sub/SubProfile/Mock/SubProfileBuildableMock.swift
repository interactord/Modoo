import RIBs
@testable import Application

// MARK: - SubProfileBuildableMock

class SubProfileBuildableMock: Builder<SubProfileDependency> {

  // MARK: Lifecycle

  init() {
    super.init(dependency: SubProfileDependencyMock())
  }

  // MARK: Fileprivate

  fileprivate var initailState: ProfileDisplayModel.State { .initialState() }

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
    let viewController = SubProfileViewController(node: .init())
    let interactor = SubProfileInteractor(
      presenter: viewController,
      initialState: initailState,
      userUseCase: userUseCase,
      uid: uid)
    interactor.listener = listener

    return SubProfileRouter(
      interactor: interactor,
      viewController: viewController)
  }

}
