import Foundation

extension String {

  func isValidEmail() -> Bool {
    let match = NSPredicate(format: "SELF MATCHES %@", "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}")
    return match.evaluate(with: self)
  }

}
