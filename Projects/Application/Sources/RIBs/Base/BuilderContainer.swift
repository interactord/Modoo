import RIBs

// MARK: - BuilderContainable

protocol BuilderContainable {
  static func register<T: Buildable>(builder: T.Type, with id: String)
  static func resolve<T>(for id: String) -> T.Type
}

// MARK: - BuilderContainer

class BuilderContainer: BuilderContainable {

  // MARK: Internal

  static let shared = BuilderContainer()

  static func register<T: Buildable>(builder: T.Type, with id: String) {
    shared.container.merge([id: builder]){ $1 }
  }

  static func resolve<T>(for id: String) -> T.Type {
    // swiftlint:disable:next force_cast
    shared.container[id] as! T.Type
  }

  // MARK: Private

  private var container = [String: Buildable.Type]()

}
