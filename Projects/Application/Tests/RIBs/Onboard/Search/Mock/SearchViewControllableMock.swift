import RIBs
import RxRelay
import RxSwift
import UIKit
@testable import Application

// MARK: - SearchViewControllableMock

class SearchViewControllableMock: ViewControllableMock, SearchPresentable {
  var listener: SearchPresentableListener?

}

// MARK: SearchViewControllable

extension SearchViewControllableMock: SearchViewControllable {
}
