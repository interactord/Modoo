import Foundation
import Promises

protocol FirebaseMediaUploading {
  func upload(image: UIImage?, directoryName: String) -> Promise<String>

}
