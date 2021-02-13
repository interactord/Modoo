import RIBs

// MARK: - ProfileInteractable

protocol ProfileInteractable: Interactable {
  var router: ProfileRouting? { get set }
  var listener: ProfileListener? { get set }
}

// MARK: - ProfileViewControllable

protocol ProfileViewControllable: ViewControllable {
}

// MARK: - ProfileRouter

final class ProfileRouter: ViewableRouter<ProfileInteractable, ProfileViewControllable>, ProfileRouting {

  override init(interactor: ProfileInteractable, viewController: ProfileViewControllable) {
    super.init(interactor: interactor, viewController: viewController)
    interactor.router = self
  }

  deinit {
    print("ProfileRouter deinit...")
  }
}
