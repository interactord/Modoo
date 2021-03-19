import AsyncDisplayKit
import ReactorKit
import RIBs
import RxIGListKit
import RxOptional
import RxSwift
import RxViewController
import UIKit

// MARK: - ProfilePresentableListener

protocol ProfilePresentableListener: AnyObject {
  var action: ActionSubject<ProfileDisplayModel.Action> { get }
  var state: Observable<ProfileDisplayModel.State> { get }
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

  lazy var dataSource: RxListAdapterDataSource<ProfileSectionModel> = {
    weak var listener = self.listener
    return .init { _, object in

      switch object {
      case let .information(itemModel):
        return SectionController<SectionDisplayModel<UserInformationSectionModel.Header, EmptyItemModel, EmptyItemModel>>(
          elementKindTypes: [.header],
          supplementaryViewHeaderBlockType: { ProfileInformationCellNode(item: $0) })
      case let .userContent(itemModel):
        let sectionController = SectionController<SectionDisplayModel<ProfileContentSectionModel.Header, ProfileContentSectionModel.Cell, EmptyItemModel>>(
          elementKindTypes: [.header],
          supplementaryViewHeaderBlockType: { _ in ProfileSubMenuCellNode() },
          sizeForItemWidthBlock: { (UIScreen.main.bounds.width - 2) / 3 },
          nodeForItemBlock: { ProfilePostCellNode(item: $0) },
          selectedCellItemBlock: { item in
            listener?.action.onNext(.loadPost(item))
          })
        sectionController.minimumLineSpacing = 1
        return sectionController
      }
    }
  }()

  weak var listener: ProfilePresentableListener? {
    didSet { bind(listener: listener) }
  }

}

// MARK: ListenerBindable

extension ProfileViewController: ListenerBindable {

  func bindAction(listener: ProfilePresentableListener) {
    rx.viewDidAppear
      .mapTo(.load)
      .bind(to: listener.action)
      .disposed(by: disposeBag)

    node.moreButtonTapStream
      .mapTo(.logout)
      .bind(to: listener.action)
      .disposed(by: disposeBag)
  }

  func bindState(listener: ProfilePresentableListener) {
    listener.state
      .map {[
        ProfileSectionModel.information(itemModel: $0.informationSectionItemModel),
        ProfileSectionModel.userContent(itemModel: $0.contentsSectionItemModel),
      ]}
      .bind(to: adapter.rx.objects(for: dataSource))
      .disposed(by: disposeBag)

    listener.state
      .map { $0.informationSectionItemModel.headerItem.userName }
      .bind(to: node.titleBinder)
      .disposed(by: disposeBag)
  }

}
