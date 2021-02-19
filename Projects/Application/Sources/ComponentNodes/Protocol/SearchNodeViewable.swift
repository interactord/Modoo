import AsyncDisplayKit
import RxSwift

protocol SearchNodeViewable {
  var node: ASDisplayNode { get }
  var searchTextStream: Observable<String>? { get }
}
