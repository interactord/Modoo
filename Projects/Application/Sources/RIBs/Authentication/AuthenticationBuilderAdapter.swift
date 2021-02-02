import RIBs

let AuthenticationBuilderID = "AuthenticationBuilderID"

// MARK: - AuthenticationBuilderAdapter

final class AuthenticationBuilderAdapter: Builder<AuthenticationDependency> {

  private final class Component: RIBs.Component<AuthenticationDependency>, AuthenticationDependency {
  }

  private weak var listener: AuthenticationListener?

}

// MARK: AuthenticationListener

extension AuthenticationBuilderAdapter: AuthenticationListener {

  func routeToLoggedIn() {
    listener?.routeToLoggedIn()
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
