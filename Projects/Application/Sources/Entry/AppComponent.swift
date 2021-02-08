import RIBs

import Domain

final class AppComponent: Component<EmptyDependency>, RootDependency {

  // MARK: Lifecycle

  init(useCaseProvider: UseCaseProviderType) {
    self.useCaseProvider = useCaseProvider

    super.init(dependency: EmptyComponent())
  }

  // MARK: Internal

  let useCaseProvider: UseCaseProviderType

}
