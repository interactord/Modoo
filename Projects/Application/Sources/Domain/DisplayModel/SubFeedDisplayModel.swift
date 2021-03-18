import Foundation

enum SubFeedDisplayModel {

  struct State: PresentableState {
    var userName: String

    static func initialState() -> State {
      State(userName: "")
    }
  }
}
