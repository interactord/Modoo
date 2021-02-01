import AsyncDisplayKit
import BonMot

final class FormPrimaryButtonNode: ASButtonNode {

  // MARK: Lifecycle

  init(title: String) {
    super.init()

    setAttributedTitle(title.styled(with: Const.titleTextStyle), for: .normal)
    backgroundColor = Const.backgroundColor
    cornerRadius = Const.connerRadius
  }

  // MARK: Internal

  struct Const {
    static let backgroundColor = UIColor.systemPurple.withAlphaComponent(0.3)
    static let titleTextStyle = StringStyle(.font(.systemFont(ofSize: 12, weight: .bold)), .color(.white))
    static let connerRadius: CGFloat = 5.0
  }

}
