import RxSwift

@testable import Application

// MARK: - FirebaseCommentUseCaseMock

class FirebaseCommentUseCaseMock {

  var networkState: TestUtil.NetworkState = .succeed
  let firebaseAPINetworkingMock = FirebaseAPINetworkingMock()

  var fetchCommentCallCount = 0
  var fetchCommentHandler: (() -> Void)?
}

// MARK: CommentUseCase

extension FirebaseCommentUseCaseMock: CommentUseCase {

  func fetchComment(postID: String) -> Observable<[CommentRepositoryModel]> {
    fetchCommentCallCount += 1
    fetchCommentHandler?()

    return .create { observer in
      switch self.networkState {
      case .succeed:
        observer.onNext([.defaultValue()])
      case .failed:
        observer.onError(TestUtil.TestErrors.testMockError)
      }

      observer.onCompleted()

      return Disposables.create()
    }
  }
}
