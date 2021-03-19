import RIBs
@testable import Application

// MARK: - SubProfileBuildableMock

class SubProfileBuildableMock: Builder<SubProfileDependency> {

  // MARK: Lifecycle

  init() {
    super.init(dependency: SubProfileDependencyMock())
  }

  // MARK: Fileprivate

  fileprivate var initailState: SubProfileDisplayModel.State { .defaultValue() }

  fileprivate var userUseCase: UserUseCase {
    FirebaseUserUseCase(
      authenticating: FirebaseAuthentication(),
      apiNetworking: FirebaseAPINetwork())
  }

  fileprivate var postUseCase: PostUseCase {
    FirebasePostUseCase(
      apiNetworking: FirebaseAPINetwork(),
      mediaUploading: FirebaseMediaUploader())
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
      postUseCase: postUseCase,
      uid: uid)
    interactor.listener = listener

    return SubProfileRouter(
      interactor: interactor,
      viewController: viewController)
  }

}
