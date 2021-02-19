import AsyncDisplayKit
import ReactorKit

protocol FormLoginNodeViewable {
  var node: ASScrollNode { get }
  var stateStream: Observable<LoginDisplayModel.FormState> { get }
  var loginTabStream: Observable<Void> { get }
  var helpSignInTapStream: Observable<Void> { get }
  var keyboardDismissEventNodeTapStream: Observable<Void> { get }
}
