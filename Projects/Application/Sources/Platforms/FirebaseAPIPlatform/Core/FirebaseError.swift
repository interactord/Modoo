import Foundation

// MARK: - FirebaseError

enum FirebaseError: Error {
  case noData
}

// MARK: CustomStringConvertible

extension FirebaseError: CustomStringConvertible {
  var description: String {
    switch self {
    case .noData:
      return  "The collection snapshot or in data is empty"
    }
  }
}

// MARK: LocalizedError

extension FirebaseError: LocalizedError {
  var errorDescription: String? {
    switch self {
    case .noData:
      return NSLocalizedString(description, comment: "empty data")
    }
  }
}
