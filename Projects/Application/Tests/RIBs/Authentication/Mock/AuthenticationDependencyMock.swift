import RIBs

@testable import Application

class AuthenticationDependencyMock: AuthenticationDependency {
  var mediaPickerUseCase: MediaPickerUseCase {
    UIMediaPickerPlatformUseCase()
  }

}
