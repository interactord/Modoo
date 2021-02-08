import Foundation

// MARK: - UseCaseProviderType

public protocol UseCaseProviderType {
  var mediaPickerUseCase: MediaPickerUseCase { get }
}

// MARK: - UseCaseProvider

public final class UseCaseProvider: UseCaseProviderType {

  // MARK: Lifecycle

  public init(mediaPickerUseCase: MediaPickerUseCase) {
    self.mediaPickerUseCase = mediaPickerUseCase
  }

  // MARK: Public

  public let mediaPickerUseCase: MediaPickerUseCase

}
