import Foundation

open class Selection<T>: ObservableObject {
  @Published public var currentItem: T? = nil
  @Published public var items = [T]()

  public init() {}
}