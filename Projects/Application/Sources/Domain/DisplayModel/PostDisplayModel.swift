import UIKit

enum PostDisplayModel {

  struct State: Equatable, PresentableState {
    var photo: UIImage
    var caption: String
    var isLoading: Bool
    var errorMessage: String

    static func initialState() -> State {
      State(
        photo: .init(),
        caption: "",
        isLoading: false,
        errorMessage: "")
    }
  }
}
