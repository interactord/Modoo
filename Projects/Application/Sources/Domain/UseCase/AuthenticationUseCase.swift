import Foundation
import RxSwift

protocol AuthenticationUseCase {
  func register(domain: RegisterDisplayModel.State) -> Observable<Result<Void, Error>>

  var authenticationToken: String { get }
}
