import Foundation

enum TestUtil {
  enum TestErrors: Error {
    case testMockError

    var localizedDescription: String {
      switch self {
      case .testMockError:
        return "testMockError"
      }
    }
  }

  struct Const {
    static var timeout: DispatchTimeInterval = .milliseconds(300)
  }
}
