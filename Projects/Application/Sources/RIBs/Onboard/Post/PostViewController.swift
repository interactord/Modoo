import AsyncDisplayKit
import ReactorKit
import RIBs
import RxSwift
import UIKit

// MARK: - PostPresentableAction

enum PostPresentableAction: Equatable {
  case cancel
  case typingCaption(String)
  case share
  case loading(Bool)
}

// MARK: - PostPresentableListener

protocol PostPresentableListener: AnyObject {
  typealias Action = PostPresentableAction
  typealias State = PostDisplayModel.State

  var action: ActionSubject<Action> { get }
  var state: Observable<State> { get }
}

// MARK: - PostViewController

final class PostViewController: ASDKViewController<PostContainerNode>, PostPresentable, PostViewControllable {

  // MARK: Lifecycle

  deinit {
    print("PostViewController deinit...")
  }

  // MARK: Internal

  let disposeBag = DisposeBag()

  weak var listener: PostPresentableListener? {
    didSet { bind(listener: listener) }
  }
}

extension PostViewController {
  private func bind(listener: PostPresentableListener?) {
    guard let listener = listener else { return }
    bindAction(listener: listener)
    bindState(listener: listener)
  }

  private func bindAction(listener: PostPresentableListener) {
    node
      .cancelButtonTapStream
      .mapTo(.cancel)
      .bind(to: listener.action)
      .disposed(by: disposeBag)

    node
      .captionStream
      .map { .typingCaption($0) }
      .bind(to: listener.action)
      .disposed(by: disposeBag)

    node
      .shareButtonTapStream
      .mapTo(.share)
      .bind(to: listener.action)
      .disposed(by: disposeBag)

  }

  private func bindState(listener: PostPresentableListener) {
    let state = listener.state.share()

    state
      .map { $0.photo }
      .bind(to: node.postImageBinder)
      .disposed(by: disposeBag)
  }
}
