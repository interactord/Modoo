import RxSwift
import UIKit

// MARK: - TestError

enum TestError: Error, LocalizedError {
  case test
  var errorDescription: String? {
    "test"
  }
}

// MARK: - FirebaseAuthenticationUseCase

struct FirebaseAuthenticationUseCase: AuthenticationUseCase {

  // MARK: Internal

  let authenticating: FirebaseAuthenticating
  let mediaUploading: FirebaseMediaUploading
  let apiNetworking: FirebaseAPINetworking

  var authenticationToken: String {
    authenticating.authenticationToken
  }

  func register(domain: RegisterDisplayModel.State) -> Observable<Void> {
    Observable.zip(
      authenticating.create(email: domain.formState.email, password: domain.formState.password).asObservable(),
      mediaUploading.upload(image: domain.photo, directoryName: Const.directoryName).asObservable())
      .map { uid, imagePath -> (String, String, [String: Any]) in
        let model = UserRepositoryModel(domain: domain, uid: uid, profileImageURL: imagePath)
        return (uid, Const.collectionName, model.dictionary)
      }
      .flatMap { apiNetworking.create(rootUID: $0.0, rootCollection: $0.1, dictionary: $0.2) }
  }

  func login(domain: LoginDisplayModel.State) -> Observable<Void> {
    authenticating
      .login(email: domain.formState.email, password: domain.formState.password)
      .asObservable()
  }

  func logout() {
    authenticating.logout()
  }

  // MARK: Private

  private struct Const {
    static var directoryName = "profile_images"
    static var collectionName = "users"
  }

}
