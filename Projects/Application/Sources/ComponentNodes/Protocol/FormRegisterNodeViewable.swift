import AsyncDisplayKit
import ReactorKit

protocol FormRegisterNodeViewable {
  var node: ASScrollNode { get }
  var stateStream: Observable<RegisterDisplayModel.FormState> { get }
  var signUpButtonTapStream: Observable<Void> { get }
  var plusButtonTapStream: Observable<Void> { get }
  var keyboardDismissEventNodeTapStream: Observable<Void> { get }
  var plusButtonImageBinder: Binder<UIImage?> { get }
}
