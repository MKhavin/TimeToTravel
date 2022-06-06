struct DecodedTicket: Decodable {
    let startCity: String
    let startCityCode: String
    let endCity: String
    let endCityCode: String
    let startDate: String
    let endDate: String
    let price: Double
    let searchToken: String
}

struct TicketsData: Decodable {
    let data: [DecodedTicket]
}
