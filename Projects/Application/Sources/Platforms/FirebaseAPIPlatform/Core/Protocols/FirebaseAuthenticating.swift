import Foundation
import RxSwift

protocol FirebaseAuthenticating {
  var authenticationToken: String { get }
  func create(email: String, password: String) -> Single<String>

}
