import UIKit

#if canImport(SwiftUI) && DEBUG
import SwiftUI

struct UIViewControllerPreview<ViewController: UIViewController> {
  let viewController: ViewController

  init(_ builder: @escaping () -> ViewController) {
    viewController = builder()
  }
}

extension UIViewControllerPreview: UIViewControllerRepresentable {
  func makeUIViewController(context: Context) -> some UIViewController {
    viewController
  }

  func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
  }
}
#endif
