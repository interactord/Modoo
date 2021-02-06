import AsyncDisplayKit
import BonMot

final class FormSecondaryButtonNode: ASButtonNode {

  // MARK: Lifecycle

  init(type: ContentType) {
    super.init()
    setAttributedTitle(type.buttonTitle, for: .normal)
  }

  // MARK: Internal

  enum ContentType {
    case helpSignIn
    case signIn
    case signUp

    // MARK: Internal

    var buttonTitle: NSAttributedString {
      switch self {
      case .helpSignIn:
        return  NSAttributedString.composed(of: [
          "Forget your password? ".styled(with: Const.leftTextStyle),
          "Get help signing in.".styled(with: Const.rightTextStyle),
        ])
      case .signIn:
        return  NSAttributedString.composed(of: [
          "Don't have account? ".styled(with: Const.leftTextStyle),
          "Sign In".styled(with: Const.rightTextStyle),
        ])
      case .signUp:
        return  NSAttributedString.composed(of: [
          "Already have account? ".styled(with: Const.leftTextStyle),
          "Sign Up".styled(with: Const.rightTextStyle),
        ])
      }
    }
  }

  struct Const {
    static let leftTextStyle = StringStyle(
      .font(.systemFont(ofSize: 12)),
      .color(.init(white: 1, alpha: 0.7)))
    static let rightTextStyle = StringStyle(
      .font(.systemFont(ofSize: 12, weight: .bold)),
      .color(.white))
  }

}
