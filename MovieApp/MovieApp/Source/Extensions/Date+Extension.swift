
import Foundation

extension Date {
  
  func isEqualTo(_ date: Date) -> Bool {
     return self == date
   }
   
   func isGreaterThan(_ date: Date) -> Bool {
      return self > date
   }
   
   func isSmallerThan(_ date: Date) -> Bool {
      return self < date
   }
  
	func dateString(dateFormat: DateFormatType) -> String {
		let formatter = DateFormatter()
		formatter.locale = Locale(identifier: "en_US")
    formatter.dateFormat = dateFormat.rawValue
		return formatter.string(from: self)
	}
	
	func dateString(date: Date) -> String {
		let formatter = DateFormatter()
		formatter.dateFormat = "dd.MM.yyyy"
		return formatter.string(from: date)
	}
}
