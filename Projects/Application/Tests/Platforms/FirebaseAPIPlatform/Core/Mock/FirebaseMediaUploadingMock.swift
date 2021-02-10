import Foundation
import Promises

@testable import Application

class FirebaseMediaUploadingMock: FirebaseMediaUploading {

  var networkState: TestUtil.NetworkState = .succeed

  func upload(image: UIImage?, directoryName: String) -> Promise<String> {
    .init { fulfill, reject in
      switch self.networkState {
      case .succeed:
        return fulfill("test")
      case .failed:
        reject(TestUtil.TestErrors.testMockError)
      }
    }
  }

}
