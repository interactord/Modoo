import Foundation
import RxSwift

protocol PostUseCase {
  func uploadPost(displayModel: PostDisplayModel.State, user: UserRepositoryModel) -> Observable<Void>
  func fetchPosts() -> Observable<[PostReposityModel]>
}
