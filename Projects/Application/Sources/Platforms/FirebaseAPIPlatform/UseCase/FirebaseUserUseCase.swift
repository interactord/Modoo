import RxSwift

struct FirebaseUserUseCase: UserUseCase {

  // MARK: Internal

  let authenticating: FirebaseAuthenticating
  let apiNetworking: FirebaseAPINetworking

  func fetchUser() -> Observable<UserRepositoryModel> {
    apiNetworking
      .get(uid: authenticationToken, collection: Const.collectionName)
      .asObservable()
  }

  func fetchUser(uid: String) -> Observable<UserRepositoryModel> {
    apiNetworking
      .get(uid: uid, collection: Const.collectionName)
      .asObservable()
  }

  func fetchUsers() -> Observable<[UserRepositoryModel]> {
    apiNetworking
      .get(collection: Const.collectionName)
      .asObservable()
  }

  // MARK: Private

  private struct Const {
    static var collectionName = "users"
  }

  private var authenticationToken: String {
    authenticating.authenticationToken
  }

}
