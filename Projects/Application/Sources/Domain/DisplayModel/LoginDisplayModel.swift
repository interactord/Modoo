import Foundation

enum LoginDisplayModel {

  struct FormState: Equatable {
    var email = ""
    var password = ""
    var isAllInputValid = false
  }

  struct State: Equatable, PresentableState {
    var formState: FormState
    var isLoading: Bool
    var errorMessage: String

    static func initialState() -> Self {
      State(formState: .init(), isLoading: false, errorMessage: "")
    }
  }

}
