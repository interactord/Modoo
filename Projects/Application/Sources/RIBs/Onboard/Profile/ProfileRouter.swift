import RIBs

// MARK: - ProfileInteractable

protocol ProfileInteractable: Interactable, SubFeedListener, CommentListener {
  var router: ProfileRouting? { get set }
  var listener: ProfileListener? { get set }
}

// MARK: - ProfileViewControllable

protocol ProfileViewControllable: ViewControllable, UIViewControllerViewable {
}

// MARK: - ProfileRouter

final class ProfileRouter: ViewableRouter<ProfileInteractable, ProfileViewControllable> {

  // MARK: Lifecycle

  init(
    interactor: ProfileInteractable,
    viewController: ProfileViewControllable,
    subFeedBuilder: SubFeedBuildable,
    commentBuilder: CommentBuildable)
  {
    defer { interactor.router = self }
    self.subFeedBuilder = subFeedBuilder
    self.commentBuilder = commentBuilder
    super.init(interactor: interactor, viewController: viewController)
  }

  deinit {
    print("ProfileRouter deinit...")
  }

  // MARK: Internal

  var navigatingRoutings = [String: ViewableRouting]()

  // MARK: Private

  private struct Const {
    static let subFeedID = "subFeedID"
  }

  private var subFeedBuilder: SubFeedBuildable
  private var commentBuilder: CommentBuildable

}

// MARK: ProfileRouting, NavigatingViewableRouting

extension ProfileRouter: ProfileRouting, NavigatingViewableRouting {
  func routeToSubFeed(model: ProfileContentSectionModel.Cell) {
    let router = subFeedBuilder.build(withListener: interactor, model: model)
    navigatingRoutings = push(router: router, id: Const.subFeedID)
  }

  func routeToBackFromSubFeed() {
    navigatingRoutings = pop(id: Const.subFeedID)
  }
}
