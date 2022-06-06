import Foundation

extension Date {
    func formatted(dateFormat: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "ru_RU")
        dateFormatter.setLocalizedDateFormatFromTemplate(dateFormat)
        return dateFormatter.string(from: self)
    }
}
