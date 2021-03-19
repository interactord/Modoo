import UIKit

enum OnboardDisplayModel {

  enum Action: Equatable {
    case postImage(UIImage)
  }

  struct State: Equatable, PresentableState {

    static func initialState() -> State {
      State()
    }
  }
}
