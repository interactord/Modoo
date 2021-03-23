import Foundation
import RxSwift

protocol CommentUseCase {
  func fetchComment(postID: String) -> Observable<[CommentRepositoryModel]>
}
