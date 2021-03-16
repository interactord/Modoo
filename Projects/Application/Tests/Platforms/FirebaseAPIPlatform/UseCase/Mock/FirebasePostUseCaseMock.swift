import RxSwift
@testable import Application

class FirebasePostUseCaseMock: PostUseCase {

  var networkState: TestUtil.NetworkState = .succeed
  let firebaseAPINetworkingMock = FirebaseAPINetworkingMock()
  var uploadPostCallCount = 0
  var uploadPostHandler: (() -> Void)?
  var fetchPostsCallCount = 0
  var fetchPostsHandler: (() -> Void)?
  var fetchPostsForUUIDCallCount = 0
  var fetchPostsForUUIDHandler: (() -> Void)?

  func uploadPost(displayModel: PostDisplayModel.State, user: UserRepositoryModel) -> Observable<Void> {
    uploadPostCallCount += 1
    uploadPostHandler?()

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

  func fetchPosts() -> Observable<[PostReposityModel]> {
    fetchPostsCallCount += 1
    fetchPostsHandler?()

    return .create { observer in
      switch self.networkState {
      case .succeed:
        observer.onNext([])
      case .failed:
        observer.onError(TestUtil.TestErrors.testMockError)
      }

      observer.onCompleted()

      return Disposables.create()
    }
  }

  func fetchPosts(uid: String) -> Observable<[PostReposityModel]> {
    fetchPostsForUUIDCallCount += 1
    fetchPostsForUUIDHandler?()

    return .create { observer in
      switch self.networkState {
      case .succeed:
        observer.onNext([
          .init(id: "test1", caption: "", likes: 0, imageURL: "", ownerUID: "", ownerProfileImageURL: "", ownerUserName: "", timestamp: 0),
          .init(id: "test2", caption: "", likes: 0, imageURL: "", ownerUID: "", ownerProfileImageURL: "", ownerUserName: "", timestamp: 0),
        ])
      case .failed:
        observer.onError(TestUtil.TestErrors.testMockError)
      }

      observer.onCompleted()

      return Disposables.create()
    }
  }
}
