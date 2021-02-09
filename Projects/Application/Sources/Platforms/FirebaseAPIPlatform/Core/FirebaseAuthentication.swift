import FirebaseAuth
import Foundation
import Promises

struct FirebaseAuthentication: FirebaseAuthenticating {

  func create(email: String, password: String) -> Promise<String> {
    .init { fulfill, reject in
      Auth.auth().createUser(withEmail: email, password: password) { result, error in
        if let error = error { reject(error) }
        return fulfill(result?.user.uid ?? "")
      }
    }
  }
}
