import Foundation

// MARK: - UseCaseProviderType

protocol UseCaseProviderType {
  var mediaPickerUseCase: MediaPickerUseCase { get }
}

// MARK: - UseCaseProvider

final class UseCaseProvider: UseCaseProviderType {

  // MARK: Lifecycle

  init(mediaPickerUseCase: MediaPickerUseCase) {
    self.mediaPickerUseCase = mediaPickerUseCase
  }

  // MARK: Internal

  let mediaPickerUseCase: MediaPickerUseCase

}
