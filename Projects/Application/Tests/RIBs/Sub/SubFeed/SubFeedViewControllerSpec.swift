import Nimble
import Quick

@testable import Application

class SubFeedViewControllerSpec: QuickSpec {
  override func spec() {
    // swiftlint:disable implicitly_unwrapped_optional
    var viewController: SubFeedViewController!
    var interactor: SubFeedInteractor!

    beforeEach {
      viewController = SubFeedViewController(node: .init())
      var state = SubFeedDisplayModel.State(postContentSectionItemModels: [.init(repositoryModel: .defaultValue())])
      state.focusIndex = 0
      interactor = SubFeedInteractor(presenter: viewController, initialState: state, postUseCase: FirebasePostUseCaseMock())
    }
    afterEach {
      viewController = nil
      interactor = nil
    }

    describe("화면 로드가 완료되면") {
      beforeEach {
        viewController.listener = interactor
        viewController.loadView()
        viewController.viewDidLoad()
      }

      it("ing...") {
        expect(viewController).toNot(beNil())
      }
    }
  }
}
