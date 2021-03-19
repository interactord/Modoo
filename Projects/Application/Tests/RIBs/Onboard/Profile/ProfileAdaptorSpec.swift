import Nimble
import Quick
@testable import Application

class ProfileAdaptorSpec: QuickSpec {

  override func spec() {
    // swiftlint:disable implicitly_unwrapped_optional
    var adapter: ProfileBuilderAdapter!
    // swiftlint:disable implicitly_unwrapped_optional
    var listener: ProfileListenerMock!

    let id = "ProfileAdaptorSpecID"
    BuilderContainer.register(builder: ProfileBuilderAdapter.self, with: id)

    beforeEach {
      let builderType: ProfileBuilderAdapter.Type = BuilderContainer.resolve(for: id)
      adapter = builderType.init(dependency: ProfileDependencyMock())
      listener = ProfileListenerMock()
    }
    afterEach {
      adapter = nil
      listener = nil
    }

    describe("빌드가 되고나서") {
      beforeEach {
        _ = adapter.build(withListener: listener)
      }

      context("routeToOnboard 호출 시") {
        beforeEach {
          adapter.routeToAuthentication()
        }

        it("authenticationListener routeToOnboard가 불린다") {
          expect(listener.routeToAuthenticationCallCount) == 1
        }
      }

      context("routeToSubFeed 호출 시") {
        beforeEach {
          adapter.routeToSubFeed(model: .defaultValue())
        }

        it("authenticationListener routeToSubFeed가 불린다") {
          expect(listener.routeToSubFeedCallCount) == 1
        }
      }
    }
  }
}
