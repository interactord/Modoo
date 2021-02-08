import RxSwift
import UIKit

// MARK: - MediaPickerPlatform

final class MediaPickerPlatform: NSObject {

  // MARK: Lifecycle

  public override init() {
    super.init()
  }

  deinit {
    print("MediaPicker deinit...")
  }

  // MARK: Internal

  weak var targetViewController: UIViewController?

  // MARK: Private

  private enum MediaPickerAction {
    case photo(observer: AnyObserver<(UIImage?, UIImage?)>)
  }

  private var currentAction: MediaPickerAction?
}

extension MediaPickerPlatform {

  // MARK: Internal

  func selectImage(
    targetViewController: UIViewController?,
    source: UIImagePickerController.SourceType = .photoLibrary,
    allowsEditing: Bool = false) -> Observable<(UIImage?, UIImage?)>
  {
    Observable.create { [weak self] observer in
      guard let self = self else { return Disposables.create() }

      self.targetViewController = targetViewController
      self.currentAction = MediaPickerAction.photo(observer: observer)

      let picker = UIImagePickerController()
      picker.sourceType = source
      picker.allowsEditing = allowsEditing
      picker.delegate = self

      DispatchQueue.main.async {
        self.targetViewController?.present(picker, animated: true)
      }

      return Disposables.create()
    }
  }

  // MARK: Private

  private func processPhoto(
    info: [UIImagePickerController.InfoKey: Any],
    observer: AnyObserver<(UIImage?, UIImage?)>)
  {
    let originalImage = info[.originalImage] as? UIImage
    let editedImage = info[.editedImage] as? UIImage
    observer.onNext((originalImage, editedImage))
    observer.onCompleted()
  }
}

// MARK: UINavigationControllerDelegate, UIImagePickerControllerDelegate

extension MediaPickerPlatform: UINavigationControllerDelegate, UIImagePickerControllerDelegate {
  func imagePickerController(
    _ picker: UIImagePickerController,
    didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any])
  {
    DispatchQueue.main.async { [weak self] in
      self?.targetViewController?.dismiss(animated: true)
      self?.targetViewController = nil
    }

    guard let action = currentAction else { return }

    switch action {
    case let .photo(observer):
      processPhoto(info: info, observer: observer)
    }
  }

  func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
    DispatchQueue.main.async { [weak self] in
      self?.targetViewController?.dismiss(animated: true)
      self?.targetViewController = nil
    }

    guard let action = currentAction else { return }

    switch action {
    case let .photo(observer):
      observer.onCompleted()
    }
  }
}
