import Nimble
import Quick
@testable import Application

class SearchInteractorSpec: QuickSpec {
  override func spec() {
    // swiftlint:disable implicitly_unwrapped_optional
    var interactor: SearchInteractor!
    // swiftlint:disable implicitly_unwrapped_optional
    var viewController: SearchViewControllableMock!
    // swiftlint:disable implicitly_unwrapped_optional
    var userUseCaseMock: FirebaseUserUseCaseMock!
    // swiftlint:disable implicitly_unwrapped_optional
    var searchRoutingMock: SearchRoutingMock!

    beforeEach {
      viewController = SearchViewControllableMock()
      userUseCaseMock = FirebaseUserUseCaseMock()
      let state = SearchDisplayModel.State.defaultValue()
      interactor = SearchInteractor(
        presenter: viewController,
        initialState: state,
        userUseCase: userUseCaseMock)
      searchRoutingMock = SearchRoutingMock(
        interactable: interactor,
        viewControllable: viewController)
      interactor.router = searchRoutingMock
    }
    afterEach {
      interactor = nil
      viewController = nil
      userUseCaseMock = nil
    }

    describe("활성화 이후") {
      beforeEach {
        interactor.activate()
      }
      afterEach {
        interactor.deactivate()
      }

      context("현재 로딩중일 경우") {
        beforeEach {
          interactor.action.onNext(.loading(true))
        }

        context("load 액션이 들어올 경우") {
          beforeEach {
            interactor.action.onNext(.load)
          }

          it("현재 State의 UserContentSectionItem은 변화가 없다") {
            expect(interactor.currentState.tempUserContentSectionItemModel.cellItems.count).toEventually(equal(0), timeout: TestUtil.Const.timeout)
            expect(interactor.currentState.userContentSectionItemModel.cellItems.count).toEventually(equal(0), timeout: TestUtil.Const.timeout)
          }
        }
      }

      context("현재 로딩중이 아닐 경우") {
        beforeEach {
          interactor.action.onNext(.loading(false))
        }

        context("load 액션이 불리고 useCase에서 성공적으로 데이터를 가져올 경우") {
          beforeEach {
            userUseCaseMock.networkState = .succeed
            interactor.action.onNext(.load)
          }

          it("현재 State의 UserContentSectionItem의 cellItems 카운트는 0이 아니다") {
            expect(interactor.currentState.tempUserContentSectionItemModel.cellItems.count).toNotEventually(equal(0), timeout: TestUtil.Const.timeout)
            expect(interactor.currentState.userContentSectionItemModel.cellItems.count).toNotEventually(equal(0), timeout: TestUtil.Const.timeout)
            expect(interactor.currentState.isLoading).toNotEventually(equal(true), timeout: TestUtil.Const.timeout)
            expect(interactor.currentState.errorMessage).toEventually(equal(""), timeout: TestUtil.Const.timeout)
          }

          context("일치하지 않는 검색어를 가져오는 경우") {
            beforeEach {
              interactor.action.onNext(.typingSearch("%"))
            }

            it("현재 State의 UserContentSectionItem의 cellItems 카운트는 0이다") {
              expect(interactor.currentState.tempUserContentSectionItemModel.cellItems.count).toNotEventually(equal(0), timeout: TestUtil.Const.timeout)
              expect(interactor.currentState.userContentSectionItemModel.cellItems.count).toEventually(equal(0), timeout: TestUtil.Const.timeout)
            }
          }

          context("일지하는 검색어를 가져오는 경우") {
            beforeEach {
              interactor.action.onNext(.typingSearch("test"))
            }

            it("현재 State의 UserContentSectionItem의 cellItems 카운트는 0이 아니다") {
              expect(interactor.currentState.tempUserContentSectionItemModel.cellItems.count).toNotEventually(equal(0), timeout: TestUtil.Const.timeout)
              expect(interactor.currentState.userContentSectionItemModel.cellItems.count).toNotEventually(equal(0), timeout: TestUtil.Const.timeout)
            }
          }
        }

        context("load 액션이 불리고 useCase에서 데이터를 가져오는데 에러가 발생한 경우") {
          beforeEach {
            userUseCaseMock.networkState = .failed
            interactor.action.onNext(.load)
          }

          it("현재 State의 UserContentSectionItem의 cellItems 카운트는 0이고, 에러메세지는 빈값이 아니다") {
            expect(interactor.currentState.tempUserContentSectionItemModel.cellItems.count).toEventually(equal(0), timeout: TestUtil.Const.timeout)
            expect(interactor.currentState.userContentSectionItemModel.cellItems.count).toEventually(equal(0), timeout: TestUtil.Const.timeout)
            expect(interactor.currentState.isLoading).toNotEventually(equal(true), timeout: TestUtil.Const.timeout)
            expect(interactor.currentState.errorMessage).toNotEventually(equal(""), timeout: TestUtil.Const.timeout)
          }
        }

        context("사용자검색에서 사용자를 선택한 경우") {
          beforeEach {
            interactor.action.onNext(.loadUser(.init()))
          }

          it("라우터의 routeToSubProfileUUID 메서드를 호출한다") {
            expect(searchRoutingMock.routeToSubProfileUUIDCallCount) == 1
          }
        }
      }

      context("메서드 테스트") {
        context("routeToBack 메서드가 불리면") {
          beforeEach {
            interactor.routeToBack()
          }

          it("라우터의 routeToBack 메서드가 불린다") {
            expect(searchRoutingMock.routeToBackCallCount) == 1
          }
        }
      }
    }
  }
}
