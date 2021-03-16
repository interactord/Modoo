import RIBs

// MARK: - SubProfileDependency

protocol SubProfileDependency: Dependency {
}

// MARK: - SubProfileComponent

final class SubProfileComponent: Component<SubProfileDependency> {
  fileprivate var initailState: ProfileDisplayModel.State { .initialState() }
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

// MARK: - SubProfileBuildable

protocol SubProfileBuildable: Buildable {
  func build(withListener listener: SubProfileListener, uid: String) -> SubProfileRouting
}

// MARK: - SubProfileBuilder

final class SubProfileBuilder: Builder<SubProfileDependency>, SubProfileBuildable {

  // MARK: Lifecycle

  override init(dependency: SubProfileDependency) {
    super.init(dependency: dependency)
  }

  deinit {
    print("SubProfileBuilder deinit...")
  }

  // MARK: Internal

  func build(withListener listener: SubProfileListener, uid: String) -> SubProfileRouting {
    let component = SubProfileComponent(dependency: dependency)
    let viewController = SubProfileViewController(node: .init())
    let interactor = SubProfileInteractor(
      presenter: viewController,
      initialState: component.initailState,
      userUseCase: component.userUseCase,
      postUseCase: component.postUseCase,
      uid: uid)
    interactor.listener = listener
    return SubProfileRouter(interactor: interactor, viewController: viewController)
  }
}
