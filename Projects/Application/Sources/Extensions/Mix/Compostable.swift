import UIKit

// MARK: - Compostable

protocol Compostable {
  associatedtype Element
  static func merge(list: [Element]) -> Element
}

// MARK: - UIEdgeInsets + Compostable

extension UIEdgeInsets: Compostable {
  static func merge(list: [UIEdgeInsets]) -> UIEdgeInsets {
    list.reduce(UIEdgeInsets.zero) { current, next in
      UIEdgeInsets(
        top: current.top + next.top,
        left: current.left + next.left,
        bottom: current.bottom + next.bottom,
        right: current.right + next.right)
    }
  }
}