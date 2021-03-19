import UIKit

enum OnboardDisplayModel {

  enum Action: Equatable {
    case postImage(UIImage)
  }

  struct State: Equatable, DefaultValueUsable {

    static func defaultValue() -> Self {
      State()
    }
  }
}
