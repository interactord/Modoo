import AsyncDisplayKit

// MARK: - TextFieldNode

final class TextFieldNode: ASDisplayNode {

  // MARK: Lifecycle

  override init() {
    super.init()

    setViewBlock {
      let textField = TextField()
      textField.borderStyle = .none
      return textField
    }
    style.height = .init(unit: .points, value: getLineHeight())
  }

  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  deinit {
    print("TextFiledNode deinit...")
  }

  // MARK: Internal

  var textField: TextField? { view as? TextField }
  var textContainerInset: UIEdgeInsets = .zero {
    didSet {
      textField?.textContainerInset = textContainerInset
      style.height = .init(
        unit: .points,
        value: getLineHeight() + textContainerInset.top + textContainerInset.bottom)
      setNeedsLayout()
    }
  }
  var attributedPlaceholder: NSAttributedString? {
    didSet {
      textField?.attributedPlaceholder = attributedPlaceholder
    }
  }
  var defaultTextAttributes: [NSAttributedString.Key: Any]? {
    didSet {
      textField?.defaultTextAttributes = defaultTextAttributes ?? [:]
    }
  }
  var isSecureTextEntry: Bool = false {
    didSet {
      textField?.isSecureTextEntry = isSecureTextEntry
    }
  }
  var keyboardAppearance: UIKeyboardAppearance = .default {
    didSet {
      textField?.keyboardAppearance = keyboardAppearance
    }
  }
  var enablesReturnKeyAutomatically: Bool = false {
    didSet {
      textField?.enablesReturnKeyAutomatically = enablesReturnKeyAutomatically
    }
  }
  var keyboardType: UIKeyboardType = .default {
    didSet {
      textField?.keyboardType = keyboardType
    }
  }

  // MARK: Private

  private func getLineHeight() -> CGFloat {
    guard let font = textField?.font else { return UIFont.systemFont(ofSize: 17).lineHeight }
    return font.lineHeight
  }

}

// MARK: - TextField

class TextField: UITextField {

  // MARK: Lifecycle

  deinit {
    print("TextField deinit...")
  }

  // MARK: Internal

  var textContainerInset: UIEdgeInsets = .zero {
    didSet {
      guard oldValue != textContainerInset else { return }
      setNeedsLayout()
    }
  }

  override func textRect(forBounds bounds: CGRect) -> CGRect {
    .init(
      x: bounds.origin.x + textContainerInset.left,
      y: bounds.origin.y + textContainerInset.top,
      width: bounds.width - textContainerInset.left - textContainerInset.right,
      height: bounds.height - textContainerInset.top - textContainerInset.bottom)
  }

  override func editingRect(forBounds bounds: CGRect) -> CGRect {
    textRect(forBounds: bounds)
  }

}
