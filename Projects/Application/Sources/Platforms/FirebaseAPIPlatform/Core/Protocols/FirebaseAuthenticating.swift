import Foundation
import Promises

protocol FirebaseAuthenticating {
  func create(email: String, password: String) -> Promise<String>

}
