import RIBs

@testable import Application

class RegisterDependencyMock: RegisterDependency {
  var mediaPickerUseCase: MediaPickerUseCase {
    MediaPickerPlatformUseCase()
  }

}
