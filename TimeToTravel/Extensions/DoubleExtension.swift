import Foundation

extension Double {
    func currencyFormatted() -> String {
        let numberFormatter = NumberFormatter()
        numberFormatter.locale = Locale(identifier: "ru_RU")
        numberFormatter.numberStyle = .currencyISOCode
        
        return numberFormatter.string(from: self as NSNumber) ?? "0 RUB"
    }
}
