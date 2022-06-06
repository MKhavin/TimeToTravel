import Foundation

protocol TicketsManagerSocket {
    func getTicket(by item: Int) -> Ticket
    func setLikeState(of ticket: Int)
}

class TicketsManager {
    var tickets: [Ticket] = []
    
    func getTicket(by item: Int) -> Ticket {
        tickets[item]
    }
    
    func setLikedState(of item: Int) {
        tickets[item].isLiked = !tickets[item].isLiked
    }
}
