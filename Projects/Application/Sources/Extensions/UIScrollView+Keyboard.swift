import UIKit

extension UIScrollView {
  func scrollWhenKeyboardEvent(height: CGFloat) {
    let keyboardInsets = UIEdgeInsets(top: 0, left: 0, bottom: height, right: 0)
    contentInset = keyboardInsets
    scrollIndicatorInsets = keyboardInsets
  }
}
