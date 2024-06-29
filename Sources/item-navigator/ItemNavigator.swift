import SwiftUI

open class ItemNavigator<T: Identifiable>: ObservableObject {
  @ObservedObject public var selection: Selection<T> = Selection()

  public var onUpdate: (_ item: T, _ time: Double) -> Void = { _, _ in }

  public init() {}

  open func next() -> T? {
    navigate(true)
  }

  open func previous() -> T? {
    navigate(false)
  }

  open func navigate(_ directNavigation: Bool = true) -> T? {
    var nextItem: T? = nil

    if !selection.items.isEmpty {
      if let currentItem = selection.currentItem, let index = getPosition(currentItem) {
        if directNavigation {
          if index < selection.items.count-1 {
            nextItem = selection.items[index+1]
          }
          else {
            nextItem = selection.items[0]
          }
        }
        else {
          if index > 0 {
            nextItem = selection.items[index-1]
          }
        }
      }
    }

    return nextItem
  }

  private func getPosition(_ item: T) -> Int? {
    selection.items.firstIndex(where: { sameSelection(item, $0)} )
  }

  public func select(_ item: T) {
    selection.currentItem = item
  }

  open func update(item: T, time: Double) {
    select(item)

    onUpdate(item, time)
  }

  open func sameSelection(_ item1: T?, _ item2: T?) -> Bool {
    item1?.id == item2?.id
  }
}