import UIKit

enum RegisterDisplayModel {

  struct State: Equatable, PresentableState {
    var photo: UIImage?
    var email: String
    var password: String
    var fullName: String
    var userName: String
    var errorMessage: String
    var isLoading: Bool

    static func initialState() -> Self {
      State(
        photo: nil,
        email: "",
        password: "",
        fullName: "",
        userName: "",
        errorMessage: "",
        isLoading: false)
    }
  }

}
