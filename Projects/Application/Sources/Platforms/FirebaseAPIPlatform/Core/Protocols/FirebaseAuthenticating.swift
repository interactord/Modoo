import Foundation
import Promises

protocol FirebaseAuthenticating {
  var authenticationToken: String { get }

  func create(email: String, password: String) -> Promise<String>

}
