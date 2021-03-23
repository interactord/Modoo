import RIBs

let ProfileBuilderID = "ProfileBuilderID"

// MARK: - ProfileBuilderAdapter

final class ProfileBuilderAdapter: Builder<ProfileDependency> {

  // MARK: Lifecycle

  deinit {
    print("ProfileBuilderAdapter deinit...")
  }

  // MARK: Private

  private final class Component: RIBs.Component<ProfileDependency>, ProfileDependency {
  }

  private weak var listener: ProfileListener?

}

// MARK: ProfileListener

extension ProfileBuilderAdapter: ProfileListener {
  func routeToAuthentication() {
    listener?.routeToAuthentication()
  }

  func routeToComment(item: FeedContentSectionModel.Cell) {
    listener?.routeToComment(item: item)
  }

  func routeToBackFromComment() {
    listener?.routeToBackFromComment()
  }
}

// MARK: ProfileBuildable

extension ProfileBuilderAdapter: ProfileBuildable {
  func build(withListener listener: ProfileListener) -> ProfileRouting {
    let component = Component(dependency: dependency)
    self.listener = listener

    let builder = ProfileBuilder(dependency: component)
    return builder.build(withListener: self)
  }

}
