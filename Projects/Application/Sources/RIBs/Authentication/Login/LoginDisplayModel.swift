import Foundation

enum LoginDisplayModel {

  enum Action: Equatable {
    case loginState(FormLoginReactor.State)
    case login
    case register
    case loading(Bool)
  }

  enum Mutation: Equatable {
    case setLoginState(FormLoginReactor.State)
    case setError(String)
    case setLoading(Bool)
  }

  struct State: Equatable, DefaultValueUsable {

    var formState: FormLoginReactor.State
    var isLoading: Bool
    var errorMessage: String

    static func defaultValue() -> Self {
      State(formState: .init(), isLoading: false, errorMessage: "")
    }
  }

}
