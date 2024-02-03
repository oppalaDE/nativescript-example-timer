import UIKit

class HelloSwift: NSObject {
  public var stringToReturn: String = "Hello from Swift!"

  public func getString() -> String {
    return stringToReturn;
  }
}