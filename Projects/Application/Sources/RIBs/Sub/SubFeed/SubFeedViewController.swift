import AsyncDisplayKit
import ReactorKit
import RIBs
import RxSwift
import UIKit

// MARK: - SubFeedPresentableListener

protocol SubFeedPresentableListener: AnyObject {
  var action: ActionSubject<SubFeedDisplayModel.Action> { get }
  var state: Observable<SubFeedDisplayModel.State> { get }
}

// MARK: - SubFeedViewController

final class SubFeedViewController: ASDKViewController<SubFeedContainerNode>, SubFeedPresentable, SubFeedViewControllable {

  // MARK: Lifecycle

  deinit {
    print("SubFeedViewController deinit...")
  }

  // MARK: Internal

  let disposeBag = DisposeBag()

  weak var listener: SubFeedPresentableListener? {
    didSet { bind(listener: listener) }
  }

  override func loadView() {
    super.loadView()
    view.backgroundColor = .white
  }

}

// MARK: ListenerBindable

extension SubFeedViewController: ListenerBindable {

  func bindAction(listener: SubFeedPresentableListener) {
    node.backButtonTabStream
      .mapTo(.tapClose)
      .bind(to: listener.action)
      .disposed(by: disposeBag)
  }

  func bindState(listener: SubFeedPresentableListener) {
  }
}
