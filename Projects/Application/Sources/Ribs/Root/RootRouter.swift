import RIBs

protocol RootInteractable: Interactable, LoginListener {
	var router: RootRouting? { get set }
	var listener: RootListener? { get set }
}

protocol RootViewControllable: ViewControllable {
	func present(viewController: ViewControllable)
	func dismiss(viewController: ViewControllable)
}

final class RootRouter: LaunchRouter<RootInteractable, RootViewControllable> {
	private let loginBuilder: LoginBuildable
	private var login: Routing?

	init(interactor: RootInteractable,
	     viewController: RootViewControllable,
	     loginBuilder: LoginBuildable) {
		self.loginBuilder = loginBuilder
		super.init(interactor: interactor,
		           viewController: viewController)
		interactor.router = self
	}

	override func didLoad() {
		super.didLoad()

		let login = loginBuilder.build(withListener: interactor)
		self.login = self

		attachChild(login)

		viewController.present(viewController: login.viewControllable)
	}
}

// MARK: RootRouting

extension RootRouter: RootRouting {
	func routeToLoggedIn() {}
}
