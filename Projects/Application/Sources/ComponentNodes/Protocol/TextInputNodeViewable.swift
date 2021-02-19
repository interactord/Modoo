import AsyncDisplayKit
import RxSwift
import UIKit

// MARK: - TextInputNodeViewableState

enum TextInputNodeViewableState {
  case wrong
  case valid
}

// MARK: - TextInputNodeViewable

protocol TextInputNodeViewable {
  var node: ASDisplayNode { get }
  var stateStream: Observable<TextInputNodeViewableState> { get }
  var editingDidEndOnExitEventStream: Observable<Void> { get }
  var inputTextStream: Observable<String> { get }
  var becomeFirstResponderBinder: Binder<Void> { get }
}
