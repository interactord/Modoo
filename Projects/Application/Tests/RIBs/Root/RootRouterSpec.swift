import Nimble
import Quick
@testable import Application

class RootRouterSpec: QuickSpec {
  override func spec() {
    // swiftlint:disable implicitly_unwrapped_optional
    var viewController: RootViewControllableMock!
    // swiftlint:disable implicitly_unwrapped_optional
    var router: RootRouter!
    // swiftlint:disable implicitly_unwrapped_optional
    var authenticationUseCase: FirebaseAuthenticationUseCaseMock!

    beforeEach {
      viewController = RootViewControllableMock()
      authenticationUseCase = FirebaseAuthenticationUseCaseMock()

      router = RootRouter(
        interactor: RootInteractableMock(),
        viewController: viewController,
        authenticationBuilder: AuthenticationBuildableMock(),
        onboardBuilder: OnboardBuildableMock(),
        authenticationUseCase: authenticationUseCase)
    }
    afterEach {
      viewController = nil
      router = nil
    }

    describe("RootRouter") {

      context("이미 로그인이 된 유저인 경우") {
        beforeEach {
          authenticationUseCase.state = .authenticated
        }

        context("라우팅이 로드가 되면") {
          beforeEach {
            router.didLoad()
          }

          it("viewController pushRootViewControllerCallCount는 1이 된다") {
            expect(viewController.pushRootViewControllerCallCount) == 1
          }

          it("viewController의 viewControllers는 1이 된다") {
            expect(viewController.viewControllers) == 1
          }

          it("currentChild는 온보드 라우팅으로 넘어간다") {
            expect(router.children.last is OnboardRouting) == true
          }

          context("인증화면으로 전환 요청이 들어올 경우") {
            beforeEach {
              router.routeToAuthentication()
            }

            it("viewController presentCallCount는 1가 된다") {
              expect(viewController.presentCallCount) == 1
            }

            it("viewController popRootViewControllerCallCount는 1이 된다") {
              expect(viewController.popRootViewControllerCallCount) == 1
            }

            it("viewController의 viewControllers는 0이 된다") {
              expect(viewController.viewControllers) == 0
            }

            it("currentChild는 인증라우팅으로 넘어간다") {
              expect(router.children.last is AuthenticationRouting) == true
            }
          }

          context("온보딩화면으로 전환 요청이 들어올 경우") {
            beforeEach {
              router.routeToOnboard()
            }

            it("viewController presentCallCount는 0이 된다") {
              expect(viewController.presentCallCount) == 0
            }

            it("viewController pushRootViewControllerCallCount는 1이 된다") {
              expect(viewController.pushRootViewControllerCallCount) == 1
            }

            it("viewController의 viewControllers는 1이 된다") {
              expect(viewController.viewControllers) == 1
            }
          }
        }

        context("미 로그인이 된 유저인 경우") {
          beforeEach {
            authenticationUseCase.state = .unAuthenticated
          }

          context("라우팅이 로드가 되면") {
            beforeEach {
              router.didLoad()
            }

            it("viewController presentCallCount는 1이 된다") {
              expect(viewController.presentCallCount) == 1
            }

            it("viewController viewControllers는 0이 된다") {
              expect(viewController.viewControllers) == 0
            }

            it("currentChild는 인증라우팅으로 넘어간다") {
              expect(router.children.last is AuthenticationRouting) == true
            }

            context("인증화면으로 전환 요청이 들어올 경우") {
              beforeEach {
                router.routeToAuthentication()
              }

              it("viewController presentCallCount는 1이 된다") {
                expect(viewController.presentCallCount) == 1
              }

              it("viewController viewControllers는 0이 된다") {
                expect(viewController.viewControllers) == 0
              }
            }

            context("온보딩화면으로 전환 요청이 들어올 경우") {
              beforeEach {
                router.routeToOnboard()
              }

              it("viewController presentCallCount는 1이 된다") {
                expect(viewController.presentCallCount) == 1
              }

              it("viewController viewControllers는 1이 된다") {
                expect(viewController.viewControllers) == 1
              }

              it("viewController pushRootViewControllerCallCount는 1이 된다") {
                expect(viewController.pushRootViewControllerCallCount) == 1
              }

              it("currentChild는 인증라우팅으로 넘어간다") {
                expect(router.children.last is OnboardRouting) == true
              }
            }
          }
        }
      }
    }
  }
}
