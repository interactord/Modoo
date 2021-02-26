import UIKit
import YPImagePicker

final class YPMediaPicker {

  let configuration: YPImagePickerConfiguration = {
    var config = YPImagePickerConfiguration()
    config.library.mediaType = .photo
    config.shouldSaveNewPicturesToAlbum = false
    config.startOnScreen = .library
    config.screens = [.library]
    config.hidesStatusBar = false
    config.hidesBottomBar = false
    config.library.maxNumberOfItems = 1

    return config
  }()

  lazy var picker = YPImagePicker(configuration: configuration)
}
