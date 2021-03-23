import AsyncDisplayKit
import ReactorKit
import RIBs
import RxSwift
import RxSwiftExt
import RxViewController
import UIKit

// MARK: - CommentPresentableListener

protocol CommentPresentableListener: AnyObject {
  var action: ActionSubject<CommentDisplayModel.Action> { get }
  var state: Observable<CommentDisplayModel.State> { get }
}

// MARK: - CommentViewController

final class CommentViewController: ASDKViewController<CommentContainerNode>, CommentPresentable, CommentViewControllable {

  // MARK: Lifecycle

  deinit {
    print("CommentViewController deinit...")
  }

  // MARK: Internal

  weak var listener: CommentPresentableListener? {
    didSet { bind(listener: listener) }
  }

  // MARK: Private

  private let disposeBag = DisposeBag()
}

// MARK: ListenerBindable

extension CommentViewController: ListenerBindable {
  func bindAction(listener: CommentPresentableListener) {
    rx.viewDidLoad
      .mapTo(.load)
      .bind(to: listener.action)
      .disposed(by: disposeBag)

    node
      .backButtonTapStream
      .mapTo(.back)
      .bind(to: listener.action)
      .disposed(by: disposeBag)
  }
}
