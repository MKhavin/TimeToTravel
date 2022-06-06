import Foundation

protocol MainViewPresenter: TicketsManagerSocket {
    init(view: MainView, networkService: NetworkService, model: TicketsManager, cordinator: AppCordinator)
    func getTicketsCollection()
    func getTicketsCollectionCount() -> Int
    func pushDetailsController(selectedTicket: Int)
}

protocol DataTaskResponder: AnyObject {
    func setTicketsData(by data: [DecodedTicket])
    func showErrorMessage(_ message: String)
}

// MARK: Main presenter
class MainPresenter: MainViewPresenter {
    private weak var view: MainView?
    private let networkService: NetworkService
    private let model: TicketsManager
    private let cordinator: AppCordinator
    
    required init(view: MainView,
                  networkService: NetworkService,
                  model: TicketsManager,
                  cordinator: AppCordinator) {
        self.view = view
        self.networkService = networkService
        self.model = model
        self.cordinator = cordinator
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
    
    func pushDetailsController(selectedTicket: Int) {
        guard let currentView = view else {
            return
        }
        
        cordinator.pushDetailsController(model: model, selectedTicket: selectedTicket, parent: currentView)
    }
}

// MARK: Data task responder
extension MainPresenter: DataTaskResponder {    
    func setTicketsData(by data: [DecodedTicket]) {
        data.forEach { ticket in
            model.tickets.append(Ticket(by: ticket))
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) { [unowned self] in
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
