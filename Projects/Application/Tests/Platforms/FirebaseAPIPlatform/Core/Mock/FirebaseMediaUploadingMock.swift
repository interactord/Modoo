import Foundation
import RxSwift

@testable import Application

class FirebaseMediaUploadingMock: FirebaseMediaUploading {

  var networkState: TestUtil.NetworkState = .succeed

  func upload(image: UIImage?, directoryName: String) -> Single<String> {
    .create { single in
      switch self.networkState {
      case .succeed:
        single(.success("test"))
      case .failed:
        single(.failure(TestUtil.TestErrors.testMockError))
      }

      return Disposables.create()
    }
  }

}
