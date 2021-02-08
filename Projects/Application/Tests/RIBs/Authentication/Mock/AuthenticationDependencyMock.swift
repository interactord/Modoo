import Domain
import MediaPickerPlatform
import RIBs

@testable import Application

class AuthenticationDependencyMock: AuthenticationDependency {
  var mediaPickerUseCase: MediaPickerUseCase {
    MediaPickerPlatform.UseCase()
  }

}
