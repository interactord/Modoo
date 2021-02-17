import Foundation

@testable import Application

extension UserRepositoryModel {
  static func makeMock() -> Self {
    .init(
      uid: "test uid",
      email: "test@email.com",
      fullname: "test full name",
      profileImageURL: "",
      username: "test user name")
  }
}
