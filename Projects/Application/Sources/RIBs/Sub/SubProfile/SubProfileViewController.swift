import AsyncDisplayKit
import ReactorKit
import RIBs
import RxSwift
import UIKit

// MARK: - SubProfilePresentableAction

enum SubProfilePresentableAction: Equatable {
  case load
  case loading(Bool)
}

// MARK: - SubProfilePresentableListener

protocol SubProfilePresentableListener: AnyObject {
  typealias Action = SubProfilePresentableAction
  typealias State = ProfileDisplayModel.State

  var action: ActionSubject<Action> { get }
  var state: Observable<State> { get }
}

// MARK: - SubProfileViewController

final class SubProfileViewController: ASDKViewController<SubProfileContainerNode>, SubProfilePresentable, SubProfileViewControllable {

  // MARK: Lifecycle

  deinit {
    print("SubProfileViewController deinit...")
  }

  // MARK: Internal

  let disposeBag = DisposeBag()

  weak var listener: SubProfilePresentableListener? {
    didSet { bind(listener: listener) }
  }

}

extension SubProfileViewController {
  private func bind(listener: SubProfilePresentableListener?) {
    guard let listener = listener else { return }
    bindAction(listener: listener)
    bindState(listener: listener)
  }

  private func bindAction(listener: SubProfilePresentableListener) {
    rx.viewDidLoad
      .mapTo(.load)
      .bind(to: listener.action)
      .disposed(by: disposeBag)
  }

  private func bindState(listener: SubProfilePresentableListener) {
    let state = listener.state.share()

    state
      .map { $0.informationSectionItemModel.headerItem.userName }
      .bind(to: node.titleBinder)
      .disposed(by: disposeBag)
  }
}
