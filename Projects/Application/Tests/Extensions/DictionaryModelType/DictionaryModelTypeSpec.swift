import Nimble
import Quick
import UIKit
@testable import Application

class DictionaryModelTypeSpec: QuickSpec {

  override func spec() {
    let subMock  = DictionaryModelTypeMock.Sub(text: "sub test")
    let mockList = [
      DictionaryModelTypeMock(text: "mockList1", count: 12, any: UIImage(), subModel: subMock, images: [], list: []),
      DictionaryModelTypeMock(text: "mockList2", count: 12, any: UIImage(), subModel: subMock, images: [], list: []),
    ]
    // swiftlint:disable implicitly_unwrapped_optional
    var sut: DictionaryModelTypeMock!
    var result: [String: Any]?

    beforeEach {
      sut = DictionaryModelTypeMock(
        text: "result",
        count: 1,
        any: UIImage(),
        subModel: subMock,
        images: [UIImage()],
        list: mockList)
    }
    afterEach {
      sut = nil
      result = nil
    }

    describe("딕셔나리타입으로 변환 후") {
      beforeEach {
        result = sut.dictionary
      }

      it("result의 text 키값은 result이다") {
        if let value = result?["text"] as? String {
          expect(value) == "result"
        } else {
          fail()
        }
      }

      it("result의 count 키값은 1이다") {
        if let value = result?["count"] as? Int {
          expect(value) == 1
        } else {
          fail()
        }
      }

      it("result의 any 키값은 이미지이다") {
        if let value = result?["any"] as? UIImage {
          expect(value) == UIImage()
        } else {
          fail()
        }
      }

      it("result의 subValue 키값은 subMock이다") {
        if let value = result?["subModel"] as? [String: Any], let subValue = value["text"] as? String {
          expect(subValue) == "sub test"
        } else {
          fail()
        }
      }

      it("result의 images 키값은 subMock이다") {
        if let value = result?["images"] as? [UIImage] {
          expect(value) == [UIImage()]
        } else {
          fail()
        }
      }

      it("result의 list 키값은 mockList1이다") {
        if let value = result?["list"] as? [[String: Any]], let subValue = value[0]["text"] as? String {
          expect(subValue) == "mockList1"
        } else {
          fail()
        }
      }
    }
  }
}
