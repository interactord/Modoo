import Foundation

enum SubFeedDisplayModel {

  struct State: DefaultValueUsable {
    var userName: String

    static func defaultValue() -> Self {
      State(userName: "")
    }
  }
}
