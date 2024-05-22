import SwiftUI

open class ItemNavigator<T: Identifiable> {
  @ObservedObject var selection: Selection<T>

  public init(selection: Selection<T>) {
    self.selection = selection
  }

  open func next() -> T? {
    navigate(true)
  }

  open func previous() -> T? {
    navigate(false)
  }

  open func navigate(_ directNavigation: Bool = true) -> T? {
    var nextItem: T? = nil

    if !selection.items.isEmpty,
       let index = selection.items.firstIndex(where: {sameSelection(selection.currentItem, $0)} ) {
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

    return nextItem
  }

  public func select(item: T, oldItem: T?) -> Bool {
    false
  }

  public func update(item: T, time: Double) {}

  public func sameSelection(_ item1: T?, _ item2: T?) -> Bool {
    item1 != nil && item2 != nil && item1!.id == item2!.id
  }
}