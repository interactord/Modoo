import Domain
import RIBs

let AuthenticationBuilderID = "AuthenticationBuilderID"

// MARK: - AuthenticationBuilderAdapter

final class AuthenticationBuilderAdapter: Builder<AuthenticationDependency> {

  // MARK: Lifecycle

  deinit {
    print("AuthenticationBuilderAdapter deinit")
  }

  // MARK: Private

  private final class Component: RIBs.Component<AuthenticationDependency>, AuthenticationDependency {
    var mediaPickerUseCase: MediaPickerUseCase {
      dependency.mediaPickerUseCase
    }
  }

  private weak var listener: AuthenticationListener?

}

// MARK: AuthenticationListener

extension AuthenticationBuilderAdapter: AuthenticationListener {

  func routeToOnboard() {
    listener?.routeToOnboard()
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
