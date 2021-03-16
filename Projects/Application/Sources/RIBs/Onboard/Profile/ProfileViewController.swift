import AsyncDisplayKit
import ReactorKit
import RIBs
import RxIGListKit
import RxSwift
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

  let disposeBag = DisposeBag()

  let dataSource = RxListAdapterDataSource<ProfileSectionModel> { _, object in
    switch object {
    case let .userInformationSummery(itemModel):
      return SectionController<ProfileInformationSectionItemModel>(
        elementKindTypes: [.header],
        supplementaryViewHeaderBlockType: { ProfileInformationCellNode(item: $0) })
    case let .userContent(itemModel):
      let sectionController = SectionController<ProfileContentSectionItemModel>(
        elementKindTypes: [.header],
        supplementaryViewHeaderBlockType: { _ in ProfileSubMenuCellNode() },
        sizeForItemWidthBlock: { (UIScreen.main.bounds.width - 2) / 3 },
        nodeForItemBlock: { ProfilePostCellNode(item: $0) })
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
    rx.viewDidAppear
      .mapTo(.load)
      .bind(to: listener.action)
      .disposed(by: disposeBag)

    node.moreButtonTapStream
      .mapTo(.logout)
      .bind(to: listener.action)
      .disposed(by: disposeBag)
  }

  private func bindState(listener: ProfilePresentableListener) {
    let state = listener.state.share()

    state
      .map {[
        ProfileSectionModel.userInformationSummery(itemModel: $0.informationSectionItemModel),
        ProfileSectionModel.userContent(itemModel: $0.contentsSectionItemModel),
      ]}
      .bind(to: adapter.rx.objects(for: dataSource))
      .disposed(by: disposeBag)

    state
      .map { $0.informationSectionItemModel.headerItem.userName }
      .bind(to: node.titleBinder)
      .disposed(by: disposeBag)
  }

}
