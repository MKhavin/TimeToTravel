import UIKit

protocol DetailsView: UITableViewDataSource {
    func setLikeState()
}

class DetailsViewController: UIViewController {
    // MARK: UI elements
    lazy var detailsView: DetailView = {
        let view = DetailView()
        view.toAutoLayout()
        return view
    }()
    
    // MARK: Stored properties
    var presenter: DetailsPresenter!
    
    // MARK: Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .link
        view.addSubview(detailsView)
        detailsView.routeLabel.text = presenter.getRouteTitle().uppercased()
        detailsView.tableView.dataSource = self
        setSubViewsLayout()
    }
}

// MARK: Sub functions
extension DetailsViewController {
    private func setSubViewsLayout() {
        let safeArea = view.safeAreaLayoutGuide
        let offset: CGFloat = 20
        
        NSLayoutConstraint.activate([
            detailsView.topAnchor.constraint(equalTo: safeArea.topAnchor, constant: offset),
            detailsView.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor, constant: -offset),
            detailsView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: offset),
            detailsView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: -offset)
        ])
    }
    
    private func setButtonCell(tableView: UITableView, indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: DetailView.CellIdentifier.likeButton.rawValue,
                                                       for: indexPath) as? ButtonTableViewCell else {
            return UITableViewCell()
        }
        
        cell.setCurrentLike(status: presenter.getLikeState())
        cell.delegate = self
        
        return cell
    }
    
    private func setDataCell(tableView: UITableView, indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: DetailView.CellIdentifier.ticketData.rawValue,
                                                       for: indexPath) as? DataTableViewCell else {
            return UITableViewCell()
        }
        
        let currentData = presenter.getTicket(data: indexPath.row)
        cell.set(data: currentData)
        
        return cell
    }
}

// MARK: Details view delegate
extension DetailsViewController: DetailsView {
    func setLikeState() {
        presenter.setLikeState()
    }
}

//MARK: TableView DataSource
extension DetailsViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        DetailView.CellIdentifier.allCases.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0: return 5
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
