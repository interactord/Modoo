import Promises
import RxSwift
import UIKit

struct FirebaseAuthenticationUseCase: AuthenticationUseCase {

  // MARK: Internal

  let authenticating: FirebaseAuthenticating
  let uploading: FirebaseMediaUploading
  let apiNetworking: FirebaseAPINetworking

  func register(domain: RegisterDisplayModel.State) -> Observable<Result<Void, Error>> {
    .create { observer in
      all(
        authenticating.create(email: domain.email, password: domain.password),
        uploading.upload(image: domain.photo, directoryName: Const.directoryName))
        .then { uid, imagePath -> Promise<Void> in
          let domainDictionary: [String: Any] = [
            "uid": uid,
            "email": domain.email,
            "profileImageURL": imagePath,
            "username": domain.userName,
            "fullname": domain.fullName,
          ]

          return apiNetworking.create(uid: uid, collection: Const.collectionName, dictionary: domainDictionary)
        }
        .then{ observer.onNext(.success($0)) }
        .catch{ observer.onNext(.failure($0)) }
        .always{ observer.onCompleted() }

      return Disposables.create()
    }
  }

  // MARK: Private

  private struct Const {
    static var directoryName = "user_profile"
    static var collectionName = "users"
  }

}
