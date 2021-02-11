import RIBs

@testable import Application

class OnboardDependencyMock: OnboardDependency {
  var mediaPickerUseCase: MediaPickerUseCase {
    UIMediaPickerPlatformUseCase()
  }

}
