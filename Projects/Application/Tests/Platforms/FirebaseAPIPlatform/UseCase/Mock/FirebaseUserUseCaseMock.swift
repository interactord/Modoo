import RxSwift

@testable import Application

class FirebaseUserUseCaseMock: UserUseCase {

  var networkState: TestUtil.NetworkState = .succeed
  let firebaseAuthenticatingMock = FirebaseAuthenticatingMock()
  let firebaseAPINetworkingMock = FirebaseAPINetworkingMock()
  var fetchUserCallCount: Int = 0
  var fetchUserHandler: (() -> Void)?
  var fetchUserUIDCallCount: Int = 0
  var fetchUserUIDHandler: (() -> Void)?
  var fetchUsersCallCount: Int = 0
  var fetchUsersHandler: (() -> Void)?

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

  func fetchUser(uid: String) -> Observable<UserRepositoryModel> {
    fetchUserUIDCallCount += 1
    fetchUserUIDHandler?()

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

  func fetchUsers() -> Observable<[UserRepositoryModel]> {
    fetchUsersCallCount += 1
    fetchUsersHandler?()

    return .create { observer in
      switch self.networkState {
      case .succeed:
        observer.onNext([.makeMock()])
      case .failed:
        observer.onError(TestUtil.TestErrors.testMockError)
      }

      observer.onCompleted()

      return Disposables.create()
    }
  }
}
