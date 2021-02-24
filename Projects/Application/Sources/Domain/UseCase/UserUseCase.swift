import Foundation
import RxSwift

protocol UserUseCase {
  var authenticationToken: String { get }

  func fetchUser(uid: String) -> Observable<UserRepositoryModel>
  func fetchUsers() -> Observable<[UserRepositoryModel]>
  func follow(to uid: String) -> Observable<Void>
  func unFollow(to uid: String) -> Observable<Void>
  func isFollowed(uid: String) -> Observable<Bool>
  func fetchUserSocial(uid: String) -> Observable<UserSocialRepositoryModel>
}
