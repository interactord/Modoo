import UIKit

enum PostDisplayModel {

  enum Action: Equatable {
    case cancel
    case typingCaption(String)
    case share
    case loading(Bool)
  }

  enum Mutation: Equatable {
    case setCaption(String)
    case setLoading(Bool)
    case setError(String)
  }

  struct State: Equatable, DefaultValueUsable {
    var photo: UIImage
    var caption: String
    var isLoading: Bool
    var errorMessage: String

    static func defaultValue() -> Self {
      State(
        photo: .init(),
        caption: "",
        isLoading: false,
        errorMessage: "")
    }
  }
}
