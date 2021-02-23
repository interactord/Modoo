import Foundation
import RxSwift

protocol UserUseCase {
  func fetchUser() -> Observable<UserRepositoryModel>
  func fetchUser(uid: String) -> Observable<UserRepositoryModel>
  func fetchUsers() -> Observable<[UserRepositoryModel]>
}
