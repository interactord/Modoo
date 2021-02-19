import UIKit

enum RegisterDisplayModel {

  struct FormState: Equatable {
    var email = ""
    var password = ""
    var fullName = ""
    var userName = ""
    var isAllInputValid = false
  }

  struct State: Equatable, PresentableState {
    var photo: UIImage?
    var formState: FormState
    var errorMessage: String
    var isLoading: Bool

    static func initialState() -> Self {
      State(
        photo: nil,
        formState: .init(),
        errorMessage: "",
        isLoading: false)
    }
  }

}
