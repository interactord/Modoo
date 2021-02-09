import Foundation

enum LoginDisplayModel {

  struct State: Equatable, PresentableState {
    var email: String
    var password: String

    static func initialState() -> Self {
      State(email: "", password: "")
    }
  }
}