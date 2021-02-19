import Nimble
import Quick

@testable import Application

class FormTextInputReactorSpec: QuickSpec {
  override func spec() {
    typealias State = TextInputNodeViewableState
    // swiftlint:disable implicitly_unwrapped_optional
    var reactor: FormTextInputReactor!

    let emailScope = FormTextInputReactor.Scope.email
    let passwordScope = FormTextInputReactor.Scope.password
    let plainScope = FormTextInputReactor.Scope.plain(placeholderString: "test")

    beforeEach {
      reactor = FormTextInputReactor()
    }
    afterEach {
      reactor = nil
    }

    describe("FormTextInputReactor 이메일 검증테스트") {

      context("빈 텍스트를 보내면") {
        beforeEach {
          reactor.action.onNext(.editingChanged(emailScope, ""))
        }

        it("reactor currentState state는 wrong 타입이다") {
          expect(reactor.currentState.state) == State.wrong
        }
      }

      context("잘못된 이메일 형식의 텍스트를 보내면") {
        beforeEach {
          reactor.action.onNext(.editingChanged(emailScope, "1231231"))
        }

        it("reactor currentState state는 wrong 타입이다") {
          expect(reactor.currentState.state) == State.wrong
        }
      }

      context("정상적인 이메일 형식의 텍스트를 보내면") {
        beforeEach {
          reactor.action.onNext(.editingChanged(emailScope, "asdvb@asdf.com"))
        }

        it("reactor currentState state는 valid 타입이다") {
          expect(reactor.currentState.state) == State.valid
        }
      }
    }

    describe("FormTextInputReactor 패스워드 검증테스트") {

      context("빈 텍스트 보내면") {
        beforeEach {
          reactor.action.onNext(.editingChanged(passwordScope, ""))
        }

        it("reactor currentState state는 wrong 타입이다") {
          expect(reactor.currentState.state) == State.wrong
        }
      }

      context("6자리 텍스트를 보내면") {
        beforeEach {
          reactor.action.onNext(.editingChanged(passwordScope, "123456"))
        }

        it("reactor currentState state는 wrong 타입이다") {
          expect(reactor.currentState.state) == State.wrong
        }
      }

      context("7자리 텍스트를 보내면") {
        beforeEach {
          reactor.action.onNext(.editingChanged(passwordScope, "1234567"))
        }

        it("reactor currentState state는 valid 타입이다") {
          expect(reactor.currentState.state) == State.valid
        }
      }
    }

    describe("FormTextInputReactor 일반텍스트 검증테스트") {

      context("빈 텍스트 보내면") {
        beforeEach {
          reactor.action.onNext(.editingChanged(plainScope, ""))
        }

        it("reactor currentState state는 wrong 타입이다") {
          expect(reactor.currentState.state) == State.wrong
        }
      }

      context("3자리 텍스트를 보내면") {
        beforeEach {
          reactor.action.onNext(.editingChanged(plainScope, "123"))
        }

        it("reactor currentState state는 wrong 타입이다") {
          expect(reactor.currentState.state) == State.wrong
        }
      }

      context("4자리 텍스트를 보내면") {
        beforeEach {
          reactor.action.onNext(.editingChanged(plainScope, "1234"))
        }

        it("reactor currentState state는 valid 타입이다") {
          expect(reactor.currentState.state) == State.valid
        }
      }
    }
  }
}
