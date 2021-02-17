import RxSwift

@testable import Application

class FirebaseUserUseCaseMock: UserUseCase {

  var networkState: TestUtil.NetworkState = .succeed
  let firebaseAuthenticatingMock = FirebaseAuthenticatingMock()
  let firebaseAPINetworkingMock = FirebaseAPINetworkingMock()
  var fetchUserCallCount: Int = 0
  var fetchUserHandler: (() -> Void)?

  func fetchUser() -> Observable<UserRepositoryModel> {
    fetchUserCallCount += 1
    fetchUserHandler?()

    return .create { observer in
      switch self.networkState {
      case .succeed:
        observer.onNext(.makeMock())
      case .failed:
        observer.onError(TestUtil.TestErrors.testMockError)
      }

      observer.onCompleted()

      return Disposables.create()
    }
  }
}
