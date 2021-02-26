import UIKit

extension NSAttributedString {

  func getHeight(containerWidth: CGFloat) -> CGFloat {
    let rect = boundingRect(
      with: .init(width: containerWidth, height: .greatestFiniteMagnitude),
      options: [.usesLineFragmentOrigin, .usesFontLeading],
      context: .none)
    return ceil(rect.size.height)
  }
}
