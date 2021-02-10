import Foundation
import RxSwift

protocol FirebaseMediaUploading {
  func upload(image: UIImage?, directoryName: String) -> Single<String>
}
