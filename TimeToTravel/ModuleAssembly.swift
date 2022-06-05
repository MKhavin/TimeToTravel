import UIKit

protocol ModuleAssembly {
    func assemblyMainModule() -> UIViewController
    func assemblyDetailsModule()
}

struct Builder: ModuleAssembly {
    func assemblyMainModule() -> UIViewController {
        let view = MainViewController()
        let networkService = NetworkService()
        let model = TicketsManager()
        let presenter = MainPresenter(view: view, networkService: networkService, model: model)
        view.presenter = presenter
        networkService.delegate = presenter
        
        return view
    }
    
    func assemblyDetailsModule() {
        
    }
}
