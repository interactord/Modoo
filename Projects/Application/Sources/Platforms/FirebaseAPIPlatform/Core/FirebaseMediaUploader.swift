import FirebaseStorage
import Promises
import UIKit

struct FirebaseMediaUploader: FirebaseMediaUploading {
  func upload(image: UIImage?, directoryName: String) -> Promise<String> {
    .init { fulfill, reject in
      guard let image = image, let imageData = image.jpegData(compressionQuality: 0.75) else{
        return fulfill("")
      }

      let ref = Storage.storage().reference(withPath: "/images/\(directoryName)\(UUID().uuidString)")
      ref.putData(imageData, metadata: .none) { _, error in
        if let error = error { return reject(error) }
        ref.downloadURL { url, error in
          if let error = error { return reject(error) }
          fulfill(url?.absoluteString ?? "")
        }
      }
    }
  }
}
