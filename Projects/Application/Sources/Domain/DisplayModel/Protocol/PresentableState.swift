import Foundation

protocol PresentableState {
  associatedtype State

  static func initialState() -> State

}
