import Domain
import RIBs

let RegisterBuilderID = "RegisterBuilderID"

// MARK: - RegisterBuilderAdapter

final class RegisterBuilderAdapter: Builder<RegisterDependency> {

  // MARK: Lifecycle

  deinit {
    print("RegisterBuilderAdapter deinit...")
  }

  // MARK: Private

  private final class Component: RIBs.Component<RegisterDependency>, RegisterDependency {
    var mediaPickerUseCase: MediaPickerUseCase {
      dependency.mediaPickerUseCase
    }

  }

  private weak var listener: RegisterListener?

}

// MARK: RegisterListener

extension RegisterBuilderAdapter: RegisterListener {
  func routeToOnboard() {
    listener?.routeToOnboard()
  }

  func routeToLogin() {
    listener?.routeToLogin()
  }
}

// MARK: RegisterBuildable

extension RegisterBuilderAdapter: RegisterBuildable {
  func build(withListener listener: RegisterListener) -> RegisterRouting {
    let component = Component(dependency: dependency)
    self.listener = listener

    let builder = RegisterBuilder(dependency: component)
    return builder.build(withListener: self)
  }

}
