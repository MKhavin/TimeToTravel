import Foundation

protocol DetailsPresenter: TicketsManagerSocket, AnyObject {
    init(view: DetailsView, model: TicketsManager, selectedTicket: Int, cordinator: AppCordinator)
    func setLikeState()
    func getRouteTitle() -> String
    func getLikeState() -> Bool
    func getTicket(data: Int) -> String
    var selectedTicket: Int { get }
}

class DetailsViewPresenter: DetailsPresenter {
    private let model: TicketsManager
    private weak var view: DetailsView?
    let selectedTicket: Int

    required init(view: DetailsView, model: TicketsManager, selectedTicket: Int, cordinator: AppCordinator) {
        self.view = view
        self.model = model
        self.selectedTicket = selectedTicket
    }
    
    func getTicket(by item: Int) -> Ticket {
        model.getTicket(by: item)
    }
    
    func setLikeState(of ticket: Int) {
        model.setLikedState(of: ticket)
    }
    
    func setLikeState() {
        setLikeState(of: selectedTicket)
    }
    
    func getRouteTitle() -> String {
        let ticket = getTicket(by: selectedTicket)
        return "\(ticket[.startCityCode]) - \(ticket[.endCityCode])"
    }
    
    func getLikeState() -> Bool {
        let ticket = getTicket(by: selectedTicket)
        return ticket.isLiked
    }
    
    func getTicket(data: Int) -> String {
        let ticket = getTicket(by: selectedTicket)
        
        switch data {
        case 0:
            return "Город отправления: \(ticket.startCity)"
        case 1:
            return "Город прибытия: \(ticket.endCity)"
        case 2:
            let dateFormat = "EEEE d MMMM yyyy HH:mm"
            return "Дата отправления: \(ticket.startDate.formatted(dateFormat: dateFormat))"
        case 3:
            let dateFormat = "EEEE d MMMM yyyy HH:mm"
            return "Дата прибытия: \(ticket.endDate.formatted(dateFormat: dateFormat))"
        case 4:
            return "Цена: \(ticket.price.currencyFormatted())"
        default:
            return ""
        }
    }
}
