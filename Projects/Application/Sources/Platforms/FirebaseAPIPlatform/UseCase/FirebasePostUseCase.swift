import Firebase
import RxSwift

struct FirebasePostUseCase: PostUseCase {

  // MARK: Lifecycle

  init(
    apiNetworking: FirebaseAPINetworking,
    mediaUploading: FirebaseMediaUploading)
  {
    self.apiNetworking = apiNetworking
    self.mediaUploading = mediaUploading
  }

  // MARK: Internal

  func uploadPost(displayModel: PostDisplayModel.State, user: UserRepositoryModel) -> Observable<Void> {
    mediaUploading
      .upload(image: displayModel.photo, directoryName: Const.postUpdateImageDictoryName)
      .asObservable()
      .flatMap {
        createPost(user: user, displayModel: displayModel, imageURL: $0)
      }
  }

  // MARK: Private

  private struct Const {
    static let postCollectionName = "post"
    static let postUpdateImageDictoryName = "post_images"
  }

  private let apiNetworking: FirebaseAPINetworking
  private let mediaUploading: FirebaseMediaUploading

  private func createPost(user: UserRepositoryModel, displayModel: PostDisplayModel.State, imageURL: String) -> Observable<Void> {
    let model = PostReposityModel(
      caption: displayModel.caption,
      likes: 0,
      imageURL: imageURL,
      ownerUID: user.uid,
      ownerProfileImageURL: user.profileImageURL,
      ownerUserName: user.username)
    let dictionary = model.dictionary.merging(["timestamp": Timestamp()]) { $1 }

    return apiNetworking
      .create(rootCollection: Const.postCollectionName, dictionary: dictionary)
      .asObservable()
  }

}
