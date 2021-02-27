import RxSwift

struct FirebaseUserUseCase: UserUseCase {

  // MARK: Lifecycle

  init(
    authenticating: FirebaseAuthenticating,
    apiNetworking: FirebaseAPINetworking)
  {
    self.authenticating = authenticating
    self.apiNetworking = apiNetworking
  }

  // MARK: Internal

  var authenticationToken: String {
    authenticating.authenticationToken
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

  func fetchUserSocial(uid: String) -> Observable<UserSocialRepositoryModel> {
    Observable.zip(
      apiNetworking.count(
        rootUID: uid,
        rootCollection: Const.rootUserFollowersCollectionName,
        documentCollection: Const.documentuserFollowersCollectionName)
        .asObservable(),
      apiNetworking.count(
        rootUID: uid,
        rootCollection: Const.rootUserFollowingCollectionName,
        documentCollection: Const.documentUserFollowingCollectionName)
        .asObservable())
      .map { UserSocialRepositoryModel(followers: $0.0, following: $0.1) }
  }

  // MARK: Private

  private struct Const {
    static var userCollectionName = "users"
    static var rootUserFollowingCollectionName = "following"
    static var documentUserFollowingCollectionName = "user-following"
    static var rootUserFollowersCollectionName = "followers"
    static var documentuserFollowersCollectionName = "user-followers"
  }

  private let authenticating: FirebaseAuthenticating
  private let apiNetworking: FirebaseAPINetworking

}
