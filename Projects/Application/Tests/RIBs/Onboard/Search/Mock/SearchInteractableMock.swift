import RIBs
import RxRelay
import RxSwift
@testable import Application

class SearchInteractableMock: InteractableMock, SearchInteractable {

  // MARK: Lifecycle

  override init() {
    super.init()
  }

  // MARK: Internal

  var router: SearchRouting?
  var listener: SearchListener?

}
