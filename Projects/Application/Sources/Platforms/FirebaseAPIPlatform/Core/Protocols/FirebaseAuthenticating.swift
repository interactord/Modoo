import Foundation
import RxSwift

protocol FirebaseAuthenticating {
  var authenticationToken: String { get }

  func create(email: String, password: String) -> Single<String>
  func login(email: String, password: String) -> Single<Void>
  func logout()

}
