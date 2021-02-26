import Nimble
import Quick

@testable import Application

class FormCaptionReactorSpec: QuickSpec {

  override func spec() {
    typealias State = FormCaptionReactor.State
    // swiftlint:disable implicitly_unwrapped_optional
    var reactor: FormCaptionReactor!

    beforeEach {
      reactor = FormCaptionReactor(scope: .init(placeholderText: "test", minCount: 4, maxCount: 6))
    }
    afterEach {
      reactor = nil
    }

    describe("텍스트 검증 테스트") {
      context("빈텍스트를 보낼 경우") {

        beforeEach {
          reactor.action.onNext(.typingText(""))
        }

        it("currentState text는 빈값이다") {
          expect(reactor.currentState.text) == ""
        }

        it("currentState currentTextRange는 0이다") {
          expect(reactor.currentState.currentTextRange) == 0
        }

        it("currentState isValid는 false이다") {
          expect(reactor.currentState.isValid) == false
        }
      }

      context("test라는 텍스트를 보낼 경우") {

        beforeEach {
          reactor.action.onNext(.typingText("test"))
        }

        it("currentState text는 test로 바뀐다") {
          expect(reactor.currentState.text) == "test"
        }

        it("currentState currentTextRange는 4이다") {
          expect(reactor.currentState.currentTextRange) == 4
        }

        it("currentState isValid는 false이다") {
          expect(reactor.currentState.isValid) == true
        }
      }

      context("testtest 라는 텍스트를 보낼 경우") {

        beforeEach {
          reactor.action.onNext(.typingText("testtest"))
        }

        it("currentState text는 testtest로 바뀐다") {
          expect(reactor.currentState.text) == "testtest"
        }

        it("currentState currentTextRange는 8이다") {
          expect(reactor.currentState.currentTextRange) == 8
        }

        it("currentState isValid는 false이다") {
          expect(reactor.currentState.isValid) == false
        }
      }
    }
  }
}
