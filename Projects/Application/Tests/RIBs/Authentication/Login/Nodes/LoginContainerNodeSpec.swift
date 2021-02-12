import Nimble
import Quick

@testable import Application

class LoginContainerNodeSpec: QuickSpec {
  override func spec() {
    // swiftlint:disable implicitly_unwrapped_optional
    var node: LoginContainerNode!

    let emailScope = FormTextInputReactor.Scope.email
    let passwordScope = FormTextInputReactor.Scope.password

    beforeEach {
      node = LoginContainerNode()
    }
    afterEach {
      node = nil
    }

    describe("LoginContainerNode") {

      context("레이아웃 호출 테스트") {
        beforeEach {
          _ = node.layoutSpecThatFits(
            .init(
              min: .init(width: 100, height: 100),
              max: .init(width: 200, height: 200)))
        }

        it("크래시가 발생하지 않는다") {
          expect(node).toNot(beNil())
        }
      }

      context("입력폼 테스트") {

        context("이메일이 빈값 입력시") {
          beforeEach {
            node.loginFormNode.emailInputNode.reactor?.action.onNext(.editingChanged(emailScope, nil))
          }

          it("로그인 버튼은 비활성화 된다") {
            expect(node.loginFormNode.loginButtonNode.isEnabled).toEventually(beFalse(), timeout: TestUtil.Const.timeout)
          }

          context("비밀번호가 빈값 입력시") {
            beforeEach {
              node.loginFormNode.passwordInputNode.reactor?.action.onNext(.editingChanged(passwordScope, nil))
            }

            it("로그인 버튼은 비활성화 된다") {
              expect(node.loginFormNode.loginButtonNode.isEnabled).toEventually(beFalse(), timeout: TestUtil.Const.timeout)
            }
          }

          context("비밀번호를 10자리 입력시") {
            beforeEach {
              node.loginFormNode.passwordInputNode.reactor?.action.onNext(.editingChanged(passwordScope, "1234567890"))
            }

            it("로그인 버튼은 비활성화 된다") {
              expect(node.loginFormNode.loginButtonNode.isEnabled).toEventually(beFalse(), timeout: TestUtil.Const.timeout)
            }
          }

          context("비밀번호가 빈값일 경우") {
            beforeEach {
              node.loginFormNode.passwordInputNode.reactor?.action.onNext(.editingChanged(passwordScope, nil))
            }

            it("로그인 버튼은 비활성화 된다") {
              expect(node.loginFormNode.loginButtonNode.isEnabled).toEventually(beFalse(), timeout: TestUtil.Const.timeout)
            }

            context("이메일 빈값 입력시") {
              beforeEach {
                node.loginFormNode.passwordInputNode.reactor?.action.onNext(.editingChanged(emailScope, nil))
              }

              it("로그인 버튼은 비활성화 된다") {
                expect(node.loginFormNode.loginButtonNode.isEnabled).toEventually(beFalse(), timeout: TestUtil.Const.timeout)
              }
            }

            context("잘못된 이메일 입력시") {
              beforeEach {
                node.loginFormNode.passwordInputNode.reactor?.action.onNext(.editingChanged(emailScope, "1234567890"))
              }

              it("로그인 버튼은 비활성화 된다") {
                expect(node.loginFormNode.loginButtonNode.isEnabled).toEventually(beFalse(), timeout: TestUtil.Const.timeout)
              }
            }

            context("정상적인 이메일 입력시") {
              beforeEach {
                node.loginFormNode.emailInputNode.reactor?.action.onNext(.editingChanged(emailScope, "test@test.com"))
              }

              it("로그인 버튼은 비활성화 된다") {
                expect(node.loginFormNode.loginButtonNode.isEnabled).toEventually(beFalse(), timeout: TestUtil.Const.timeout)
              }
            }

            context("비밀번호를 10자리 입력시") {
              beforeEach {
                node.loginFormNode.passwordInputNode.reactor?.action.onNext(.editingChanged(passwordScope, "1234567890"))
              }

              it("로그인 버튼은 비활성화 된다") {
                expect(node.loginFormNode.loginButtonNode.isEnabled).toEventually(beFalse(), timeout: TestUtil.Const.timeout)
              }

              context("이메일 빈값 입력시") {
                beforeEach {
                  node.loginFormNode.passwordInputNode.reactor?.action.onNext(.editingChanged(emailScope, nil))
                }

                it("로그인 버튼은 비활성화 된다") {
                  expect(node.loginFormNode.loginButtonNode.isEnabled).toEventually(beFalse(), timeout: TestUtil.Const.timeout)
                }
              }

              context("잘못된 이메일 입력시") {
                beforeEach {
                  node.loginFormNode.passwordInputNode.reactor?.action.onNext(.editingChanged(emailScope, "1234567890"))
                }

                it("로그인 버튼은 비활성화 된다") {
                  expect(node.loginFormNode.loginButtonNode.isEnabled).toEventually(beFalse(), timeout: TestUtil.Const.timeout)
                }
              }

              context("정상적인 이메일 입력시") {
                beforeEach {
                  node.loginFormNode.emailInputNode.reactor?.action.onNext(.editingChanged(emailScope, "test@test.com"))
                }

                it("로그인 버튼은 활성화 된다") {
                  expect(node.loginFormNode.loginButtonNode.isEnabled).toEventually(beTrue(), timeout: TestUtil.Const.timeout)
                }
              }
            }
          }
        }
      }
    }
  }
}
