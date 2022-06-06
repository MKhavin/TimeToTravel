import UIKit

protocol DetailsView: UITableViewDelegate, UITableViewDataSource {
    func setLikeState()
}

class DetailsViewController: UIViewController, DetailsView {

    lazy var detailsView: DetailView = {
        let view = DetailView()
        view.toAutoLayout()
        return view
    }()
    
    var presenter: DetailsPresenter!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .link
        view.addSubview(detailsView)
        setSubViewLayout()
        detailsView.routeLabel.text = presenter.getRouteTitle().uppercased()
        detailsView.tableView.delegate = self
        detailsView.tableView.dataSource = self
    }
    

}

//MARK: Sub functions
extension DetailsViewController {
    private func setSubViewLayout() {
        let safeArea = view.safeAreaLayoutGuide
        let inset: CGFloat = 20
        
        NSLayoutConstraint.activate([
            detailsView.topAnchor.constraint(equalTo: safeArea.topAnchor, constant: inset),
            detailsView.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor, constant: -inset),
            detailsView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: inset),
            detailsView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: -inset)
        ])
    }
    
    private func setButtonCell(tableView: UITableView, indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: DetailView.CellIdentifiers.likeButton.rawValue,
                                                       for: indexPath) as? ButtonTableViewCell else {
            return UITableViewCell()
        }
        
        cell.setCurrentLike(status: presenter.getLikeState())
        cell.delegate = self
        
        return cell
    }
    
    private func setDataCell(tableView: UITableView, indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: DetailView.CellIdentifiers.ticketData.rawValue,
                                                       for: indexPath) as? DataTableViewCell else {
            return UITableViewCell()
        }
        
        let currentData = presenter.getTicket(data: indexPath.row)
        cell.set(data: currentData)
        
        return cell
    }
    
    func setLikeState() {
        presenter.setLikeState()
    }
}



//MARK: TableView DataSource
extension DetailsViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        DetailView.CellIdentifiers.allCases.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0: return 4
        case 1: return 1
        default: return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            return setDataCell(tableView: tableView, indexPath: indexPath)
        case 1:
            return setButtonCell(tableView: tableView, indexPath: indexPath)
        default: return UITableViewCell()
        }
    }
}

//MARK: TableView Delegate
extension DetailsViewController: UITableViewDelegate {
    
}
