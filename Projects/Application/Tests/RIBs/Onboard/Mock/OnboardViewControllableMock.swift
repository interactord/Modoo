import RIBs
import RxRelay
import RxSwift
import UIKit
@testable import Application

// MARK: - OnboardViewControllableMock

class OnboardViewControllableMock: ViewControllableMock, OnboardPresentable {
  var listener: OnboardPresentableListener?
}

// MARK: OnboardViewControllable

extension OnboardViewControllableMock: OnboardViewControllable {}
