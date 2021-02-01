import RIBs

protocol RootInteractable: Interactable, LoginListener, OnboardListener {
	var router: RootRouting? { get set }
	var listener: RootListener? { get set }
}

protocol RootViewControllable: ViewControllable {
	func present(viewController: ViewControllable)
	func dismiss(viewController: ViewControllable)
}

final class RootRouter: LaunchRouter<RootInteractable, RootViewControllable> {
	private let loginBuilder: LoginBuildable
	private var login: ViewableRouting?
	private let onboardBuilder: OnboardBuildable
	private var onboard: ViewableRouting?
	private var currentChild: ViewableRouting?

	init(interactor: RootInteractable,
	     viewController: RootViewControllable,
	     loginBuilder: LoginBuildable,
	     onboardBuilder: OnboardBuildable) {
		self.loginBuilder = loginBuilder
		self.onboardBuilder = onboardBuilder
		super.init(interactor: interactor,
		           viewController: viewController)
		interactor.router = self
	}

	override func didLoad() {
		super.didLoad()
		routeLogin()
	}

	func cleanupViews() {
		guard let currentChild = currentChild else { return }

		viewController.dismiss(viewController: currentChild.viewControllable)
		self.currentChild = nil
	}
}

// MARK: RootRouting

extension RootRouter: RootRouting {
	func routeToLoggedIn() {
		routeOnboard()
	}
}

// MARK: - Inner Method

private extension RootRouter {
	func routeLogin() {
		cleanupViews()

		let login = loginBuilder.build(withListener: interactor)
		self.login = login
		currentChild = login

		attachChild(login)

		viewController.present(viewController: login.viewControllable)
	}

	func routeOnboard() {
		cleanupViews()

		let onboard = onboardBuilder.build(withListener: interactor)
		self.onboard = onboard
		currentChild = onboard

		attachChild(onboard)

		viewController.present(viewController: onboard.viewControllable)
	}
}
