import Foundation

enum LoginDisplayModel {

  struct State: Equatable, PresentableState {
    var email: String
    var password: String
    var isLoading: Bool
    var errorMessage: String

    static func initialState() -> Self {
      State(email: "", password: "", isLoading: false, errorMessage: "")
    }
  }

}
