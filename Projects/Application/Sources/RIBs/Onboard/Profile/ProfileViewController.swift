import AsyncDisplayKit
import RIBs
import RxIGListKit
import RxSwift
import UIKit

// MARK: - ProfilePresentableListener

protocol ProfilePresentableListener: AnyObject {
}

// MARK: - ProfileViewController

final class ProfileViewController: ASDKViewController<ProfileContainerNode>, ProfilePresentable, ProfileViewControllable {

  // MARK: Lifecycle

  deinit {
    print("ProfileViewController deinit...")
  }

  // MARK: Internal

  weak var listener: ProfilePresentableListener?

  lazy var adapter: ListAdapter = {
    let adapter = ListAdapter(updater: ListAdapterUpdater(), viewController: self)
    adapter.setASDKCollectionNode(node.collectionNode)
    return adapter
  }()

  var items = [""]

  let dispooseBag = DisposeBag()

  let objectSignal: BehaviorSubject<[UserProfileSectionModel]> = {
    let itemModel = UserProfileInformationItem(displayModel:
      .init(
        userName: "userName",
        avatarImageURL: "",
        postCount: "650",
        followingCount: "436",
        followerCount: "246k",
        bioDescription: "Just a girl and her camera. Nature, animals, food."))
    let section = UserProfileSectionModel.userInformationSummery(itemModel: itemModel)

    return .init(value: [section])
  }()

  let dataSource = RxListAdapterDataSource<UserProfileSectionModel> { _, object -> ListSectionController in
    switch object {
    case let .userInformationSummery(itemModel):
      return UserProfileInformationSectionController()
    }
  }

  override func viewDidLoad() {
    super.viewDidLoad()

    objectSignal.bind(to: adapter.rx.objects(for: dataSource)).disposed(by: dispooseBag)
  }

}
