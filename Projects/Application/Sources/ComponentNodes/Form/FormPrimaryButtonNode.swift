import AsyncDisplayKit
import BonMot
import RxCocoa
import RxSwift
import RxTexture2

final class FormPrimaryButtonNode: ASButtonNode {

  // MARK: Lifecycle

  init(type: ContentType) {
    super.init()

    setAttributedTitle(type.titleOfNormalState, for: .normal)
    setAttributedTitle(type.titleOfDisabledState, for: .disabled)
    backgroundColor = Const.backgroundColor
    borderWidth = 1.0
    cornerRadius = Const.connerRadius
    style.height = Const.height
  }

  // MARK: Internal

  enum ContentType {
    case signUp
    case signIn
    case login

    private var title: String {
      switch self {
      case .login: return "Login"
      case .signUp: return "Sign Up"
      case .signIn: return "Sign In"
      }
    }

    var titleOfNormalState: NSAttributedString {
      title.styled(with: Const.titleOfNormalStateStyle)
    }

    var titleOfDisabledState: NSAttributedString {
      title.styled(with: Const.titleOfDisabledStateStyle)
    }
  }

  let disposeBag = DisposeBag()

  override var isEnabled: Bool {
    didSet {
      borderColor = isEnabled
        ? Const.normalStateColor.cgColor
        : Const.disabledStateColor.cgColor
    }
  }

  // MARK: Private

  private struct Const {
    static let backgroundColor = UIColor.clear
    static let normalStateColor = UIColor.white
    static let disabledStateColor = UIColor.white.withAlphaComponent(0.4)
    static let titleOfNormalStateStyle =
      StringStyle(
        .font(.systemFont(ofSize: 12, weight: .bold)),
        .color(Const.normalStateColor))
    static let titleOfDisabledStateStyle =
      StringStyle(
        .font(.systemFont(ofSize: 12, weight: .bold)),
        .color(Const.disabledStateColor))
    static let connerRadius: CGFloat = 5.0
    static let height = ASDimension(unit: .points, value: 50.0)
  }
}
