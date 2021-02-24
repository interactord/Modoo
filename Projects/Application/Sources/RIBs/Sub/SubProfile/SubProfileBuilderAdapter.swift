import RIBs

let SubProfileBuilderID = "SubProfileBuilderID"

// MARK: - SubProfileBuilderAdapter

final class SubProfileBuilderAdapter: Builder<SubProfileDependency> {

  // MARK: Lifecycle

  deinit {
    print("SubProfileBuilderAdapter deinit...")
  }

  // MARK: Private

  private final class Component: RIBs.Component<SubProfileDependency>, SubProfileDependency {
  }

  private weak var listener: SubProfileListener?

}

// MARK: SubProfileListener

extension SubProfileBuilderAdapter: SubProfileListener {
  func routeToBack() {
    listener?.routeToBack()
  }

}

// MARK: SubProfileBuildable

extension SubProfileBuilderAdapter: SubProfileBuildable {
  func build(withListener listener: SubProfileListener, uid: String) -> SubProfileRouting {
    let component = Component(dependency: dependency)
    self.listener = listener

    let builder = SubProfileBuilder(dependency: component)
    return builder.build(withListener: self, uid: uid)
  }

}
