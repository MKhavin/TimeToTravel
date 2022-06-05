import Foundation

struct Ticket {
    let startCity: String
    let startCityCode: String
    let endCity: String
    let endCityCode: String
    let startDate: Date
    let endDate: Date
    let price: Int
    var isLiked: Bool = false
    
    init(by data: DecodedTicket) {
        startCity = data.startCity
        startCityCode = data.startCityCode
        endCity = data.endCity
        endCityCode = data.endCityCode
        price = data.price
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        
        startDate = dateFormatter.date(from: data.startDate) ?? Date()
        endDate = dateFormatter.date(from: data.endDate) ?? Date()
    }
}
