import BonMot

extension StringStyle {

  var dictionary: [String: Any] {
    attributes.reduce([:]) { current, next in
      current.merging([next.key.rawValue: next.value]) { $1 }
    }
  }
}
