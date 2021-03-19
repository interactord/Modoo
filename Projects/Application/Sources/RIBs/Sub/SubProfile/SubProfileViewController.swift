import AsyncDisplayKit
import ReactorKit
import RIBs
import RxIGListKit
import RxSwift
import RxViewController
import UIKit

// MARK: - SubProfilePresentableListener

protocol SubProfilePresentableListener: AnyObject {
  var action: ActionSubject<SubProfileDisplayModel.Action> { get }
  var state: Observable<SubProfileDisplayModel.State> { get }
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

  lazy var dataSource: RxListAdapterDataSource<ProfileSectionModel> = {
    weak var listener = self.listener
    return .init { _, object in

      switch object {
      case let .information(itemModel):
        return SectionController<SectionDisplayModel<UserInformationSectionModel.Header, EmptyItemModel, EmptyItemModel>>(
          elementKindTypes: [.header],
          supplementaryViewHeaderBlockType: {

            let node = SubProfileInformationCellNode(item: $0)
            if let listener = listener {
              node.followButtonTapStream
                .mapTo(.follow)
                .bind(to: listener.action)
                .disposed(by: node.disposeBag)

              node.unFollowButtonTapStream
                .mapTo(.unFollow)
                .bind(to: listener.action)
                .disposed(by: node.disposeBag)
            }
            return node
          })
      case let .userContent(itemModel):
        let sectionController = SectionController<SectionDisplayModel<ProfileContentSectionModel.Header, ProfileContentSectionModel.Cell, EmptyItemModel>>(
          elementKindTypes: [.header],
          supplementaryViewHeaderBlockType: { _ in ProfileSubMenuCellNode() },
          sizeForItemWidthBlock: { (UIScreen.main.bounds.width - 2) / 3 },
          nodeForItemBlock: { ProfilePostCellNode(item: $0) })
        sectionController.minimumLineSpacing = 1
        return sectionController
      }
    }
  }()

  weak var listener: SubProfilePresentableListener? {
    didSet { bind(listener: listener) }
  }

}

// MARK: ListenerBindable

extension SubProfileViewController: ListenerBindable {

  func bindAction(listener: SubProfilePresentableListener) {
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

  func bindState(listener: SubProfilePresentableListener) {
    listener.state
      .map {[
        ProfileSectionModel.information(itemModel: $0.informationSectionItemModel),
        ProfileSectionModel.userContent(itemModel: $0.contentsSectionItemModel),
      ]}
      .bind(to: adapter.rx.objects(for: dataSource))
      .disposed(by: disposeBag)

    listener.state
      .map { $0.informationSectionItemModel.headerItem.userName }
      .bind(to: node.headerNode.titleBinder)
      .disposed(by: disposeBag)
  }
}
