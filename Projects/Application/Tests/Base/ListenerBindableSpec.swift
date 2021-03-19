import Nimble
import Quick

@testable import Application

class ListenerBindableSpec: QuickSpec {
  override func spec() {
    // swiftlint:disable implicitly_unwrapped_optional
    var sut: ListenerBindableMock!

    beforeEach {
      sut = ListenerBindableMock()
    }
    afterEach {
      sut = nil
    }

    describe("기능 테스트") {
      context("bind 메서드에 listener가 nil 주입이 될 경우") {
        beforeEach {
          sut.bind(listener: nil)
        }

        it("bindAction 메서드가 호출되지  않는다") {
          expect(sut.bindActionCallCount) == 0
        }

        it("bindState 메서드가 호출되지  않는다") {
          expect(sut.bindStateCallCount) == 0
        }
      }

      context("bind 메서드에 listener가 주입이 될 경우") {
        beforeEach {
          sut.bind(listener: "test")
        }

        it("bindAction 메서드가 호출된다") {
          expect(sut.bindActionCallCount) == 1
        }

        it("bindState 메서드가 호출된다") {
          expect(sut.bindStateCallCount) == 1
        }
      }
    }
  }
}
