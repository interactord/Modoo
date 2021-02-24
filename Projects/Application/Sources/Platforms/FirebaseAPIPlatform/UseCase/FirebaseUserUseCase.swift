import RxSwift
import RxSwiftExt

struct FirebaseUserUseCase: UserUseCase {

  // MARK: Internal

  let authenticating: FirebaseAuthenticating
  let apiNetworking: FirebaseAPINetworking

  func fetchUser() -> Observable<UserRepositoryModel> {
    apiNetworking
      .get(uid: authenticationToken, collection: Const.userCollectionName)
      .asObservable()
  }

  func fetchUser(uid: String) -> Observable<UserRepositoryModel> {
    apiNetworking
      .get(uid: uid, collection: Const.userCollectionName)
      .asObservable()
  }

  func fetchUsers() -> Observable<[UserRepositoryModel]> {
    apiNetworking
      .get(collection: Const.userCollectionName)
      .asObservable()
  }

  func follow(to uid: String) -> Observable<Void> {
    Observable.zip(
      apiNetworking
        .create(
          rootUID: authenticationToken,
          rootCollection: Const.rootUserFollowingCollectionName,
          documentCollection: Const.documentUserFollowingCollectionName,
          documentUID: uid,
          dictionary: [:])
        .asObservable(),
      apiNetworking
        .create(
          rootUID: uid,
          rootCollection: Const.rootUserFollowersCollectionName,
          documentCollection: Const.documentuserFollowersCollectionName,
          documentUID: authenticationToken,
          dictionary: [:])
        .asObservable())
      .mapTo(Void())
  }

  func unFollow(to uid: String) -> Observable<Void> {
    Observable.zip(
      apiNetworking
        .delete(
          rootUID: authenticationToken,
          rootCollection: Const.rootUserFollowingCollectionName,
          documentCollection: Const.documentUserFollowingCollectionName,
          documentUID: uid)
        .asObservable(),
      apiNetworking
        .delete(
          rootUID: uid,
          rootCollection: Const.rootUserFollowersCollectionName,
          documentCollection: Const.documentuserFollowersCollectionName,
          documentUID: authenticationToken)
        .asObservable())
      .mapTo(Void())
  }

  func isFollowed(uid: String) -> Observable<Bool> {
    apiNetworking
      .find(
        rootUID: authenticationToken,
        rootCollection: Const.rootUserFollowingCollectionName,
        documentCollection: Const.documentUserFollowingCollectionName,
        documentUID: uid)
      .asObservable()
  }

  // MARK: Private

  private struct Const {
    static var userCollectionName = "users"
    static var rootUserFollowingCollectionName = "following"
    static var documentUserFollowingCollectionName = "user-following"
    static var rootUserFollowersCollectionName = "followers"
    static var documentuserFollowersCollectionName = "user-followers"
  }

  private var authenticationToken: String {
    authenticating.authenticationToken
  }

}
