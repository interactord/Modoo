import AsyncDisplayKit
import ReactorKit
import RIBs
import RxIGListKit
import RxSwift
import RxViewController
import UIKit

// MARK: - SubProfilePresentableAction

enum SubProfilePresentableAction: Equatable {
  case load
  case loading(Bool)
  case back
  case follow
}

// MARK: - SubProfilePresentableListener

protocol SubProfilePresentableListener: AnyObject {
  typealias Action = SubProfilePresentableAction
  typealias State = ProfileDisplayModel.State

  var action: ActionSubject<Action> { get }
  var state: Observable<State> { get }
}

// MARK: - SubProfileViewController

final class SubProfileViewController: ASDKViewController<SubProfileContainerNode>, SubProfilePresentable, SubProfileViewControllable {

  // MARK: Lifecycle

  deinit {
    print("SubProfileViewController deinit...")
  }

  // MARK: Internal

  let disposeBag = DisposeBag()

  lazy var adapter: ListAdapter = {
    let adapter = ListAdapter(updater: ListAdapterUpdater(), viewController: self)
    adapter.setASDKCollectionNode(node.collectionNode)
    return adapter
  }()

  let dataSource = RxListAdapterDataSource<SubProfileSectionModel> { adapter, object in
    weak var viewController = adapter.viewController as? SubProfileViewController

    switch object {
    case let .userInformationSummery(itemModel):
      return SectionController<ProfileInformationSectionItemModel>(
        elementKindTypes: [.header],
        supplementaryViewHeaderBlockType: {
          guard let listener = viewController?.listener else { return ASCellNode() }
          let node = SubProfileInformationCellNode(item: $0)
          node.followButtonTapStream
            .mapTo(.follow)
            .bind(to: listener.action)
            .disposed(by: node.disposeBag)

          return node
        })
    case let .userContent(itemModel):
      let sectionController = SectionController<ProfileContentSectionItemModel>(
        elementKindTypes: [.header],
        supplementaryViewHeaderBlockType: { _ in ProfileSubMenuCellNode() },
        sizeForItemWidthBlock: { (UIScreen.main.bounds.width - 2) / 3 },
        nodeForItemBlock: { _ in ProfilePostCellNode() })
      sectionController.minimumLineSpacing = 1
      return sectionController
    }
  }

  weak var listener: SubProfilePresentableListener? {
    didSet { bind(listener: listener) }
  }

}

extension SubProfileViewController {
  private func bind(listener: SubProfilePresentableListener?) {
    guard let listener = listener else { return }
    bindAction(listener: listener)
    bindState(listener: listener)
  }

  private func bindAction(listener: SubProfilePresentableListener) {
    rx.viewDidLoad
      .mapTo(.load)
      .bind(to: listener.action)
      .disposed(by: disposeBag)

    node
      .backButtonTapStream
      .mapTo(.back)
      .bind(to: listener.action)
      .disposed(by: disposeBag)
  }

  private func bindState(listener: SubProfilePresentableListener) {
    let state = listener.state.share()

    state
      .map {[
        SubProfileSectionModel.userInformationSummery(itemModel: $0.informationSectionItemModel),
        SubProfileSectionModel.userContent(itemModel: $0.contentsSectionItemModel),
      ]}
      .bind(to: adapter.rx.objects(for: dataSource))
      .disposed(by: disposeBag)

    state
      .map { $0.informationSectionItemModel.headerItem.userName }
      .bind(to: node.headerNode.titleBinder)
      .disposed(by: disposeBag)
  }
}
