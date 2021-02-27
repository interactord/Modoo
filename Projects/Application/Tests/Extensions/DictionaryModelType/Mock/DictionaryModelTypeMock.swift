import Foundation
import UIKit
@testable import Application

// MARK: - DictionaryModelTypeMock

struct DictionaryModelTypeMock {
  struct Sub: DictionaryModelType {
    let text: String
  }

  let text: String
  let count: Int
  let any: UIImage
  let subModel: DictionaryModelType
  let images: [UIImage]
  let list: [DictionaryModelTypeMock]?
}

// MARK: DictionaryModelType

extension DictionaryModelTypeMock: DictionaryModelType {
}
