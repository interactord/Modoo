import RIBs

let RegisterBuilderID = "RegisterBuilderID"

// MARK: - RegisterBuilderAdapter

final class RegisterBuilderAdapter: Builder<RegisterDependency> {

  private final class Component: RIBs.Component<RegisterDependency>, RegisterDependency {
  }

  private weak var listener: RegisterListener?
}

// MARK: RegisterListener

extension RegisterBuilderAdapter: RegisterListener {
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
