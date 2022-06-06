import Foundation

struct Ticket {
    enum Property {
        case startCity
        case startCityCode
        case endCity
        case endCityCode
        case startDate
        case endDate
        case price
        case isLiked
    }
    
    let startCity: String
    let startCityCode: String
    let endCity: String
    let endCityCode: String
    let startDate: Date
    let endDate: Date
    let price: Double
    var isLiked: Bool = false
    
    subscript(property: Property) -> Any {
        switch property {
        case .startCity:
            return self.startCity
        case .startCityCode:
            return self.startCityCode
        case .endCity:
            return self.endCity
        case .endCityCode:
            return self.endCityCode
        case .startDate:
            return self.startDate
        case .endDate:
            return self.endDate
        case .price:
            return self.price
        case .isLiked:
            return self.isLiked
        }
    }
    
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
