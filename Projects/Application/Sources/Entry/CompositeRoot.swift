import RIBs

struct CompositeRoot {

  // MARK: Lifecycle

  init() {
    registerAuthenticationPart()
  }

  // MARK: Internal

  var appComponent: AppComponent {
    let mediaPickerUseCase = MediaPickerPlatformUseCase()
    let useCaseProvider = UseCaseProvider(mediaPickerUseCase: mediaPickerUseCase)

    return AppComponent(useCaseProvider: useCaseProvider)
  }

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
  }

}
