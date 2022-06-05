import Foundation

struct DecodedTicket: Decodable {
    var startCity: String
    var startCityCode: String
    var endCity: String
    var endCityCode: String
    var startDate: String
    var endDate: String
    var price: Int
    var searchToken: String
}

struct TicketsData: Decodable {
    var data: [DecodedTicket]
}
