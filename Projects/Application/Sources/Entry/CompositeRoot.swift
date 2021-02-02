import RIBs

struct CompositeRoot {

  init() {
    registerAuthenticationPart()
  }

  // MARK: Private

  private func registerAuthenticationPart() {
    BuilderContainer.register(
      builder: AuthenticationBuilderAdapter.self,
      with: AuthenticationBuilderID)
    BuilderContainer.register(
      builder: LoginBuilderAdapter.self,
      with: LoginBuilderBuilderID)
  }

}
