import Foundation

// MARK: - DictionaryModelType

protocol DictionaryModelType {
  var dictionary: [String: Any] { get }
}

extension DictionaryModelType {

  // MARK: Internal

  var dictionary: [String: Any] {
    let reflect = Mirror(reflecting: self)
    let children = reflect.children
    return toAnyHashable(elements: children)
  }

  // MARK: Private

  private func toAnyHashable(elements: AnyCollection<Mirror.Child>) -> [String: Any] {
    var dictionary = [String: Any]()

    elements.forEach { element in
      if let key = element.label {

        if let collectionValidHashable = element.value as? [AnyHashable] {
          dictionary[key] = collectionValidHashable
        }

        if let validHashable = element.value as? AnyHashable {
          dictionary[key] = validHashable
        }

        if let dictionaryModelType = element.value as? DictionaryModelType {
          dictionary[key] = dictionaryModelType.dictionary
        }

        if let dictionaryModelTypeList = element.value as? [DictionaryModelType] {
          dictionary[key] = dictionaryModelTypeList.map { $0.dictionary }
        }
      }
    }

    return dictionary
  }
}
