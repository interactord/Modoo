import UIKit

enum RegisterDisplayModel {

  enum Action: Equatable {
    case signUp
    case login
    case photo(UIImage?)
    case registerFormState(FormRegisterReactor.State)
    case loading(Bool)
  }

  enum Mutation: Equatable {
    case setPhoto(UIImage?)
    case setFormState(FormRegisterReactor.State)
    case setLoading(Bool)
    case setError(String)
  }

  struct State: Equatable, PresentableState {
    var photo: UIImage?
    var formState: FormRegisterReactor.State
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
