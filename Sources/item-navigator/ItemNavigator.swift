import SwiftUI

open class ItemNavigator<T: Identifiable>: ObservableObject {
  @ObservedObject public var selection: Selection<T> = Selection()

  public init(selection: Selection<T>? = nil) {
    if let selection = selection {
      self.selection = selection
    }
  }

  open func next() -> T? {
    navigate(true)
  }

  open func previous() -> T? {
    navigate(false)
  }

  open func navigate(_ directNavigation: Bool = true) -> T? {
    var nextItem: T? = nil

    if !selection.items.isEmpty {
      let currentItem = selection.currentItem

      if let index = selection.items.firstIndex(where: { sameSelection(currentItem, $0)} ) {
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

  open func select(item: T, oldItem: T?) -> Bool {
    false
  }

  open func update(item: T, time: Double) {}

  open func sameSelection(_ item1: T?, _ item2: T?) -> Bool {
    item1?.id == item2?.id
  }
}