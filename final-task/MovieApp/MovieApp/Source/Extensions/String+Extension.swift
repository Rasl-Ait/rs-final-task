import UIKit

extension String {
  var toInt: Int { Int(self) ?? 0 }
  var dollar: String { "S" }
  var persent: String { "%" }
  
  static func set(_ type: TextType) -> String {
    type.rawValue
  }
  
  func formatDate() -> String {
    let dateFormatterGet = DateFormatter()
    dateFormatterGet.dateFormat = "yyyy-MM-dd"

    let dateFormatter = DateFormatter()
    dateFormatter.dateStyle = .medium
    dateFormatter.timeStyle = .none
    dateFormatter.dateFormat = UIScreen.main.bounds.width <= 375 ? "MMM dd, yyyy" : "MMMM dd, yyyy"
    let dateObj: Date? = dateFormatterGet.date(from: self)
    return dateFormatter.string(from: dateObj ?? Date())
  }
  
  func toDate(withFormat format: String = "yyyy-MM-dd") -> Date {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = format
    guard let date = dateFormatter.date(from: self) else {
      preconditionFailure("Take a look to your format")
    }
    return date
  }
}
