import AsyncDisplayKit
import ReactorKit
import RIBs
import RxIGListKit
import RxSwift
import RxTexture2
import RxViewController
import UIKit

// MARK: - ProfilePresentableAction

enum ProfilePresentableAction: Equatable {
  case load
  case loading(Bool)
  case logout
}

// MARK: - ProfilePresentableListener

protocol ProfilePresentableListener: AnyObject {
  typealias Action = ProfilePresentableAction
  typealias State = ProfileDisplayModel.State

  var action: ActionSubject<Action> { get }
  var state: Observable<State> { get }
  var currentState: State { get }
}

// MARK: - ProfileViewController

final class ProfileViewController: ASDKViewController<ProfileContainerNode>, ProfilePresentable, ProfileViewControllable {

  // MARK: Lifecycle

  deinit {
    print("ProfileViewController deinit...")
  }

  // MARK: Internal

  lazy var adapter: ListAdapter = {
    let adapter = ListAdapter(updater: ListAdapterUpdater(), viewController: self)
    adapter.setASDKCollectionNode(node.collectionNode)
    return adapter
  }()

  var items = [""]

  let disposeBag = DisposeBag()

  let dataSource = RxListAdapterDataSource<ProfileSectionModel> { _, object -> ListSectionController in
    switch object {
    case let .userInformationSummery(itemModel):
      return SectionController<ProfileInformationItem>(
        elementKindTypes: [.header],
        supplementaryViewBlock: { _, _, item -> ASCellNode in
          ProfileInformationCellNode(item: item)
        })
    case let .userContent(itemModel):
      let sectionController = SectionController<ProfileContentItem>(
        elementKindTypes: [.header],
        supplementaryViewBlock: { _  in ProfileSubMenuCellNode() },
        numberOfCellItemsBlock: { _ in 10 },
        sizeForItemWidthBlock: { (UIScreen.main.bounds.width - 2) / 3 },
        nodeForItemBlock: { _, _ in ProfilePostCellNode() })
      sectionController.minimumLineSpacing = 1
      return sectionController
    }
  }

  weak var listener: ProfilePresentableListener? {
    didSet { bind(listener: listener) }
  }

}

extension ProfileViewController {

  private func bind(listener: ProfilePresentableListener?) {
    guard let listener = listener else { return }
    bindAction(listener: listener)
    bindState(listener: listener)
  }

  private func bindAction(listener: ProfilePresentableListener) {
    rx.viewDidLoad
      .map { .load }
      .bind(to: listener.action)
      .disposed(by: disposeBag)

    node.headerNode.moreButton.rx.tap
      .map { .logout }
      .bind(to: listener.action)
      .disposed(by: disposeBag)
  }

  private func bindState(listener: ProfilePresentableListener) {
    let state = listener.state.share()

    state
      .map {[
        ProfileSectionModel.userInformationSummery(itemModel: $0.informationSectionModel),
        ProfileSectionModel.userContent(itemModel: $0.contentsSectionModel),
      ]}
      .bind(to: adapter.rx.objects(for: dataSource))
      .disposed(by: disposeBag)

    state
      .map { $0.informationSectionModel.userName }
      .bind(to: node.headerNode.userName)
      .disposed(by: disposeBag)
  }

}
