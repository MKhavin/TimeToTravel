import Foundation

protocol MainViewPresenter {
    init(view: MainView, networkService: NetworkService, model: TicketsManager)
    func getTicketsCollection()
    func getTicketsCollectionCount() -> Int
    func getTicket(by item: Int) -> Ticket
    func setLikeState(of ticket: Int)
}

protocol DataTaskResponder: AnyObject {
    func setTicketsData(by data: [DecodedTicket])
    func showErrorMessage(_ message: String)
}

class MainPresenter: MainViewPresenter {
    private weak var view: MainView?
    private let networkService: NetworkService
    private let model: TicketsManager
    
    required init(view: MainView, networkService: NetworkService, model: TicketsManager) {
        self.view = view
        self.networkService = networkService
        self.model = model
    }

    func getTicketsCollection() {
        networkService.getTicketsData()
    }
    
    func getTicket(by item: Int) -> Ticket {
        model.getTicket(by: item)
    }
    
    func setLikeState(of ticket: Int) {
        model.setLikedState(of: ticket)
    }
    
    func getTicketsCollectionCount() -> Int {
        model.tickets.count
    }
}

extension MainPresenter: DataTaskResponder {    
    func setTicketsData(by data: [DecodedTicket]) {
        data.forEach { ticket in
            model.tickets.append(Ticket(by: ticket))
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) { [unowned self] in
                self.view?.reloadTicketsCollection()
        }
    }
    
    func showErrorMessage(_ message: String) {
        DispatchQueue.main.async { [unowned self] in
            let alert = ErrorAlertController(title: "Ошибка",
                                             message: message,
                                             preferredStyle: .alert)
            self.view?.show(alert: alert)
        }
    }
}
