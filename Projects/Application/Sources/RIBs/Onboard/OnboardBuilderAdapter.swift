import RIBs

let OnboardBuilderID = "OnboardBuilderID"

// MARK: - OnboardBuilderAdapter

final class OnboardBuilderAdapter: Builder<OnboardDependency> {

  // MARK: Lifecycle

  deinit {
    print("OnboardBuilderAdapter deinit")
  }

  // MARK: Private

  private final class Component: RIBs.Component<OnboardDependency>, OnboardDependency {
  }

  private weak var listener: OnboardListener?

}

// MARK: OnboardListener

extension OnboardBuilderAdapter: OnboardListener {
  func routeToAuthentication() {
    listener?.routeToAuthentication()
  }

}

// MARK: OnboardBuildable

extension OnboardBuilderAdapter: OnboardBuildable {
  func build(withListener listener: OnboardListener) -> OnboardRouting {
    let component = Component(dependency: dependency)
    self.listener = listener

    let builder = OnboardBuilder(dependency: component)
    return builder.build(withListener: self)
  }

}
