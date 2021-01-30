import RIBs

final class AppComponent: Component<EmptyDependency>, RootDependency {
  init() {
    super.init(dependency: EmptyComponent())
  }
}
