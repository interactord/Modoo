import Nimble
import Quick
@testable import Application

class ProfileViewControllerSpec: QuickSpec {
  override func spec() {
    // swiftlint:disable implicitly_unwrapped_optional
    var viewController: ProfileViewController!

    beforeEach {
      viewController = ProfileViewController(node: .init())
    }
    afterEach {
      viewController = nil
    }

    describe("화면 로드가 완료되면") {
      beforeEach {
        viewController.loadView()
        viewController.viewDidLoad()
      }

      context("더미 아이템을 1개를 담을 경우") {
        beforeEach {
          viewController.items = Array(repeating: "A", count: 1)
        }

        it("컬렉션뷰의 섹션은 1개이다") {
          expect(viewController.numberOfSections(in: viewController.node.collectionNode)) == 1
        }

        it("컬렉션뷰의 첫번째 섹현의 아이템은 3개이다") {
          expect(viewController.collectionNode(viewController.node.collectionNode, numberOfItemsInSection: 0)) == 1
        }

        it("컬렉션뷰의 1번쨰 색션의 1번째 아이템은 FeedPostCellNode이다") {
          let cellNode = viewController.collectionNode(viewController.node.collectionNode, nodeBlockForItemAt: [0, 0])()
          expect(cellNode is ProfileInformationCell).to(beTrue())
        }
      }
    }
  }
}
