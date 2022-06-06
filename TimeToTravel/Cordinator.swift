import Foundation
import UIKit

protocol AppCordinator {
    func initialRootController()
    func pushDetailsController(model: TicketsManager, selectedTicket: Int, parent: UIAdaptivePresentationControllerDelegate)
    init(builder: ModuleAssembly, navigationController: UINavigationController)
}

class Cordinator: AppCordinator {
    weak var navigationController: UINavigationController?
    let builder: ModuleAssembly
 
    func pushDetailsController(model: TicketsManager, selectedTicket: Int, parent: UIAdaptivePresentationControllerDelegate) {
        let view = builder.assemblyDetailsModule(with: model, selectedTicket: selectedTicket, cordinator: self)
        view.presentationController?.delegate = parent
        navigationController?.present(view, animated: true)
    }
    
    func initialRootController() {
        let view = builder.assemblyMainModule(cordinator: self)
        navigationController?.viewControllers = [view]
    }
    
    required init(builder: ModuleAssembly, navigationController: UINavigationController) {
        self.builder = builder
        self.navigationController = navigationController
    }
}
