import RIBs

let SubFeedBuilderID = "SubFeedBuilderID"

// MARK: - SubFeedBuilderAdapter

final class SubFeedBuilderAdapter: Builder<SubFeedDependency> {

  // MARK: Lifecycle

  deinit {
    print("SubFeedBuilderAdapter deinit...")
  }

  // MARK: Private

  private final class Component: RIBs.Component<SubFeedDependency>, SubFeedDependency {
  }

  private weak var listener: SubFeedListener?

}

// MARK: SubFeedListener

extension SubFeedBuilderAdapter: SubFeedListener {
  func routeToBackFromSubFeed() {
    listener?.routeToBackFromSubFeed()
  }

  func routeToComment(item: FeedContentSectionModel.Cell) {
    listener?.routeToComment(item: item)
  }
}

// MARK: SubFeedBuildable

extension SubFeedBuilderAdapter: SubFeedBuildable {
  func build(withListener listener: SubFeedListener, model: ProfileContentSectionModel.Cell) -> SubFeedRouting {
    let component = Component(dependency: dependency)
    self.listener = listener

    let builder = SubFeedBuilder(dependency: component)
    return builder.build(withListener: self, model: model)
  }

}
