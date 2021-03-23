import RxSwift

// MARK: - FirebaseCommentUseCase

struct FirebaseCommentUseCase {

  init(apiNetworking: FirebaseAPINetworking) {
    self.apiNetworking = apiNetworking
  }

  let apiNetworking: FirebaseAPINetworking
}

// MARK: CommentUseCase

extension FirebaseCommentUseCase: CommentUseCase {

  // MARK: Internal

  func fetchComment(postID: String) -> Observable<[CommentRepositoryModel]> {
    apiNetworking
      .get(
        rootCollection: Const.rootCollectionName,
        documentID: postID,
        collection: Const.collectionName,
        orderBy: Const.orderByKey,
        descending: true)
      .asObservable()
  }

  // MARK: Private

  private struct Const {
    static let rootCollectionName = "posts"
    static let collectionName = "comments"
    static let orderByKey = "timestamp"
  }

}
