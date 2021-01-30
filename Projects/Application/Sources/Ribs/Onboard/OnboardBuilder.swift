import RIBs

protocol OnboardDependency: Dependency {
}

final class OnboardComponent: Component<OnboardDependency> {
}

// MARK: - Builder

protocol OnboardBuildable: Buildable {
	func build(withListener listener: OnboardListener) -> OnboardRouting
}

final class OnboardBuilder: Builder<OnboardDependency> {
	override init(dependency: OnboardDependency) {
		super.init(dependency: dependency)
	}
}

// MARK: OnboardBuildable

extension OnboardBuilder: OnboardBuildable {
	func build(withListener listener: OnboardListener) -> OnboardRouting {
		_ = OnboardComponent(dependency: dependency)

		let viewController = OnboardViewController()
		let interactor = OnboardInteractor(presenter: viewController)
		interactor.listener = listener
		return OnboardRouter(interactor: interactor, viewController: viewController)
	}
}
