import Foundation

class TicketsManager {
    var tickets: [Ticket] = []
    
    func getTicket(by item: Int) -> Ticket {
        tickets[item]
    }
    
    func setLikedState(of item: Int) {
        tickets[item].isLiked = !tickets[item].isLiked
    }
}
