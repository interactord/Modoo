import FirebaseStorage
import RxSwift
import UIKit

struct FirebaseMediaUploader: FirebaseMediaUploading {

  func upload(image: UIImage?, directoryName: String) -> Single<String> {
    .create { single in
      guard let image = image, let imageData = image.jpegData(compressionQuality: 0.75) else {
        single(.success(""))
        return Disposables.create()
      }

      let referencePath = "/images/\(directoryName)\(UUID().uuidString)"
      let ref = Storage.storage().reference(withPath: referencePath)
      ref.putData(imageData, metadata: .none) { _, error in
        if let error = error { single(.failure(error)) }
        ref.downloadURL { url, error in
          if let error = error { single(.failure(error)) }
          single(.success(url?.absoluteString ?? ""))
        }
      }

      return Disposables.create()
    }
  }

}
