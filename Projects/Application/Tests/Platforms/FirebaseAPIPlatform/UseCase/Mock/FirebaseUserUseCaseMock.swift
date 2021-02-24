import RxSwift

@testable import Application

class FirebaseUserUseCaseMock: UserUseCase {

  var networkState: TestUtil.NetworkState = .succeed
  let firebaseAuthenticatingMock = FirebaseAuthenticatingMock()
  let firebaseAPINetworkingMock = FirebaseAPINetworkingMock()
  var fetchUserUIDCallCount: Int = 0
  var fetchUserUIDHandler: (() -> Void)?
  var fetchUsersCallCount: Int = 0
  var fetchUsersHandler: (() -> Void)?
  var followCallCount: Int = 0
  var followHandler: (() -> Void)?
  var unFollowCallCount: Int = 0
  var unFollowHandler: (() -> Void)?
  var isFollowedCallCount: Int = 0
  var isFollowedHandler: (() -> Void)?
  var fetchUserSocialUIDCallCount: Int = 0
  var fetchUserSocialUIDHandler: (() -> Void)?

  var authenticationToken = ""

  func fetchUser(uid: String) -> Observable<UserRepositoryModel> {
    print("fetchUser(uid: String)")
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

  func follow(to uid: String) -> Observable<Void> {
    followCallCount += 1
    followHandler?()

    return .create { observer in
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

  func unFollow(to uid: String) -> Observable<Void> {
    unFollowCallCount += 1
    unFollowHandler?()

    return .create { observer in
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

  func isFollowed(uid: String) -> Observable<Bool> {
    isFollowedCallCount += 1
    isFollowedHandler?()

    return .create { observer in
      switch self.networkState {
      case .succeed:
        observer.onNext(true)
      case .failed:
        observer.onError(TestUtil.TestErrors.testMockError)
      }

      observer.onCompleted()

      return Disposables.create()
    }
  }

  func fetchUserSocial(uid: String) -> Observable<UserSocialRepositoryModel> {
    fetchUserSocialUIDCallCount += 1
    fetchUserSocialUIDHandler?()

    return .create { observer in
      switch self.networkState {
      case .succeed:
        observer.onNext(.init())
      case .failed:
        observer.onError(TestUtil.TestErrors.testMockError)
      }

      observer.onCompleted()

      return Disposables.create()
    }
  }
}
