import ReactorKit
import RxSwift

// MARK: - ListenerBindable

protocol ListenerBindable {
  associatedtype ListenerType

  func bind(listener: ListenerType?)
  func bindAction(listener: ListenerType)
  func bindState(listener: ListenerType)
}

extension ListenerBindable {
  func bind(listener: ListenerType?) {
    guard let listener = listener else { return }
    bindAction(listener: listener)
    bindState(listener: listener)
  }

  func bindAction(listener: ListenerType) {
  }

  func bindState(listener: ListenerType) {
  }
}
