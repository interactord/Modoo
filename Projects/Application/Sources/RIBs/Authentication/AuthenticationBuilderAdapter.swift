import RIBs

let AuthenticationBuilderID = "AuthenticationBuilder"

// MARK: - AuthenticationBuilderAdapter

final class AuthenticationBuilderAdapter: Builder<AuthenticationDependency> {

  // MARK: Lifecycle

  override init(dependency: AuthenticationDependency) {
    super.init(dependency: dependency)
  }

  // MARK: Private

  private final class Component: RIBs.Component<AuthenticationDependency>, AuthenticationDependency {
  }

  private weak var listener: AuthenticationListener?
}

// MARK: AuthenticationListener

extension AuthenticationBuilderAdapter: AuthenticationListener {
  func routeToLogin() {
    listener?.routeToLogin()
  }

}

// MARK: AuthenticationBuildable

extension AuthenticationBuilderAdapter: AuthenticationBuildable {
  func build(withListener listener: AuthenticationListener) -> AuthenticationRouting {
    let component = Component(dependency: dependency)
    self.listener = listener

    let builder = AuthenticationBuilder(dependency: component)
    return builder.build(withListener: self)
  }
}
