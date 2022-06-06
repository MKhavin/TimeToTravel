import UIKit

protocol ModuleAssembly {
    func assemblyMainModule(cordinator: AppCordinator) -> UIViewController
    func assemblyDetailsModule(with model: TicketsManager?,
                               selectedTicket: Int,
                               cordinator: AppCordinator) -> UIViewController
}

struct Builder: ModuleAssembly {
    func assemblyMainModule(cordinator: AppCordinator) -> UIViewController {
        let view = MainViewController()
        let networkService = NetworkService()
        let model = TicketsManager()
        let presenter = MainPresenter(view: view,
                                      networkService: networkService,
                                      model: model,
                                      cordinator: cordinator)
        view.presenter = presenter
        networkService.delegate = presenter
        
        return view
    }
    
    func assemblyDetailsModule(with model: TicketsManager? = nil,
                               selectedTicket: Int,
                               cordinator: AppCordinator) -> UIViewController {
        let view = DetailsViewController()
        let presenter = DetailsViewPresenter(view: view,
                                             model: model ?? TicketsManager(),
                                             selectedTicket: selectedTicket,
                                             cordinator: cordinator)
        view.presenter = presenter
        
        return view
    }
}
