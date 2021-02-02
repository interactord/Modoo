import AsyncDisplayKit

extension ASDisplayNode {

  // MARK: Internal

  enum GradientDirection {
    case horizontal
    case vertical
    case adjust(CGPoint, CGPoint)

    var point: (start: CGPoint, end: CGPoint) {
      switch self {
      case .horizontal:
        return (start: .init(x: .zero, y: 0.5), end: .init(x: 1.0, y: 0.5) )
      case .vertical:
        return (start: .init(x: 0.5, y: .zero), end: .init(x: 0.5, y: 1.0))
      case let .adjust(start, end):
        return (start: start, end: end)
      }
    }
  }

  func gradientBackgroundColor(colors: [CGColor], direction: GradientDirection) {
    guard hasEmptyGradientLayer else { return }

    DispatchQueue.main.async { [weak self] in
      guard let self = self else { return }
      self.backgroundColor = .clear
      self.clipsToBounds = true

      let gradient = CAGradientLayer()
      gradient.frame = .init(origin: .zero, size: self.calculatedSize)
      gradient.colors = colors
      gradient.startPoint = direction.point.start
      gradient.endPoint = direction.point.end

      self.layer.insertSublayer(gradient, at: .zero)
    }
  }

  // MARK: Private

  private var hasEmptyGradientLayer: Bool {
    guard layer.sublayers?.first(where: { $0 is CAGradientLayer }) != nil else { return false }
    return true
  }

}
