import Foundation
import Promises

@testable import Application

class FirebaseMediaUploadingMock: FirebaseMediaUploading {

  var isSueccedCase = true

  func upload(image: UIImage?, directoryName: String) -> Promise<String> {
    .init { fulfill, reject in
      guard self.isSueccedCase else {
        return reject(TestUtil.TestErrors.testMockError)
      }
      return fulfill("succeed")
    }
  }

}
