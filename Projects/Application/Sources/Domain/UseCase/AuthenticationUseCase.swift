import Foundation
import RxSwift

protocol AuthenticationUseCase {
  var authenticationToken: String { get }

  func register(domain: RegisterDisplayModel.State) -> Observable<Void>
  func logout()
}
