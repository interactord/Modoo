import AsyncDisplayKit
import BonMot

final class FormSecondaryButtonNode: ASButtonNode {

  // MARK: Lifecycle

  init(firstPart: String, secondPart: String) {
    super.init()

    let compositeString = [
      firstPart.styled(with: Const.leftTextStyle),
      " ".styled(with: Const.leftTextStyle),
      secondPart.styled(with: Const.rightTextStyle),
    ]
    setAttributedTitle(NSAttributedString.composed(of: compositeString), for: .normal)
  }

  // MARK: Internal

  struct Const {
    static let leftTextStyle = StringStyle(
      .font(.systemFont(ofSize: 12)),
      .color(.init(white: 1, alpha: 0.7)))
    static let rightTextStyle = StringStyle(
      .font(.systemFont(ofSize: 12, weight: .bold)),
      .color(.white))
  }

}
