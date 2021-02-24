import Foundation
import RxSwift

protocol UserUseCase {
  func fetchUser() -> Observable<UserRepositoryModel>
  func fetchUser(uid: String) -> Observable<UserRepositoryModel>
  func fetchUsers() -> Observable<[UserRepositoryModel]>
  func follow(to uid: String) -> Observable<Void>
  func unFollow(to uid: String) -> Observable<Void>
  func isFollowed(uid: String) -> Observable<Bool>
}
