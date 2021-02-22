import RxSwift

struct FirebaseUserUseCase: UserUseCase {

  let authenticating: FirebaseAuthenticating
  let apiNetworking: FirebaseAPINetworking

  private var authenticationToken: String {
    authenticating.authenticationToken
  }

  func fetchUser() -> Observable<UserRepositoryModel> {
    apiNetworking
      .get(uid: authenticationToken, collection: "users")
      .asObservable()
  }

  func fetchUsers() -> Observable<[UserRepositoryModel]> {
    apiNetworking
      .get(collection: "users")
      .asObservable()
  }
}
