import Domain
import MediaPickerPlatform
import RIBs

@testable import Application

class RegisterDependencyMock: RegisterDependency {
  var mediaPickerUseCase: MediaPickerUseCase {
    MediaPickerPlatform.UseCase()
  }

}
