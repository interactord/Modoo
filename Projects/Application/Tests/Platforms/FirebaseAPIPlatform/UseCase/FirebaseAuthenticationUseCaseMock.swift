import RxSwift
import UIKit

@testable import Application

class FirebaseAuthenticationUseCaseMock: AuthenticationUseCase {

  var networkState: TestUtil.NetworkState = .succeed
  let firebaseAuthenticatingMock = FirebaseAuthenticatingMock()
  let firebaseMediaUploadingMock = FirebaseMediaUploadingMock()
  let firebaseAPINetworkingMock = FirebaseAPINetworkingMock()

  var state: TestUtil.AuthenticationState = .unAuthenticated {
    didSet {
      firebaseAuthenticatingMock.state = state
    }
  }

  var authenticationToken: String {
    firebaseAuthenticatingMock.authenticationToken
  }

  func register(domain: RegisterDisplayModel.State) -> Observable<Void> {
    .create { observer in

      switch self.networkState {
      case .succeed:
        observer.onNext(Void())
      case .failed:
        observer.onError(TestUtil.TestErrors.testMockError)
      }

      observer.onCompleted()

      return Disposables.create()
    }
  }

}
