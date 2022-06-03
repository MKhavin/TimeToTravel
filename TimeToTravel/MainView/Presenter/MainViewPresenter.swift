import Foundation

protocol MainViewPresenter {
    var tickets: [Ticket] { get }
    init(view: MainView, networkService: NetworkService)
    func getTicketsCollection()
}

protocol DataTaskResponder: AnyObject {
    func setTicketsData(by data: [Ticket])
}

class MainPresenter: MainViewPresenter {
    private(set) var tickets: [Ticket] = []
    private weak var view: MainView?
    private let networkService: NetworkService
    
    required init(view: MainView, networkService: NetworkService) {
        self.view = view
        self.networkService = networkService
    }

    func getTicketsCollection() {
        networkService.getTicketsData()
    }
}

extension MainPresenter: DataTaskResponder {
    func setTicketsData(by data: [Ticket]) {
        tickets = data
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) { [unowned self] in
                self.view?.reloadTicketsCollection()
        }
    }
}
