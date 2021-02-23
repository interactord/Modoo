import RIBs

struct CompositeRoot {

  // MARK: Lifecycle

  init() {
    registerAuthenticationPart()
  }

  // MARK: Internal

  let appComponent = AppComponent()

  // MARK: Private

  private func registerAuthenticationPart() {
    BuilderContainer.register(
      builder: AuthenticationBuilderAdapter.self,
      with: AuthenticationBuilderID)
    BuilderContainer.register(
      builder: LoginBuilderAdapter.self,
      with: LoginBuilderBuilderID)
    BuilderContainer.register(
      builder: RegisterBuilderAdapter.self,
      with: RegisterBuilderID)
    BuilderContainer.register(
      builder: OnboardBuilderAdapter.self,
      with: OnboardBuilderID)
    BuilderContainer.register(
      builder: FeedBuilderAdapter.self,
      with: FeedBuilderID)
    BuilderContainer.register(
      builder: ProfileBuilderAdapter.self,
      with: ProfileBuilderID)
    BuilderContainer.register(
      builder: SearchBuilderAdapter.self,
      with: SearchBuilderID)
    BuilderContainer.register(
      builder: SubProfileBuilderAdapter.self,
      with: SubProfileBuilderID)
  }

}
