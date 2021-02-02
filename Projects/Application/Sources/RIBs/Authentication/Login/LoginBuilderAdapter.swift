import RIBs

let LoginBuilderBuilderID = "LoginBuilderBuilderID"

// MARK: - LoginBuilderAdapter

final class LoginBuilderAdapter: Builder<LoginDependency> {

  // MARK: Lifecycle

  override init(dependency: LoginDependency) {
    super.init(dependency: dependency)
  }

  // MARK: Private

  private final class Component: RIBs.Component<LoginDependency>, LoginDependency {
  }

  private weak var listener: LoginListener?

}

// MARK: LoginListener

extension LoginBuilderAdapter: LoginListener {
  func didLogin() {
    listener?.didLogin()
  }

}

// MARK: LoginBuildable

extension LoginBuilderAdapter: LoginBuildable {
  func build(withListener listener: LoginListener) -> LoginRouting {
    let component = Component(dependency: dependency)
    self.listener = listener

    let builder = LoginBuilder(dependency: component)
    return builder.build(withListener: self)
  }

}
