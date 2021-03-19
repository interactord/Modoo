import AsyncDisplayKit
import ReactorKit
import RIBs
import RxSwift
import UIKit

// MARK: - PostPresentableListener

protocol PostPresentableListener: AnyObject {
  var action: ActionSubject<PostDisplayModel.Action> { get }
  var state: Observable<PostDisplayModel.State> { get }
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

// MARK: ListenerBindable

extension PostViewController: ListenerBindable {

  func bindAction(listener: PostPresentableListener) {
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

  func bindState(listener: PostPresentableListener) {
    listener.state
      .map { $0.photo }
      .bind(to: node.postImageBinder)
      .disposed(by: disposeBag)
  }
}
