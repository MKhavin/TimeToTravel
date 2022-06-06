import UIKit

protocol ViewShowing {
    func show(alert: UIAlertController)
}

protocol MainView: ViewShowing, UIAdaptivePresentationControllerDelegate {
    func reloadTicketsCollection()
}

class MainViewController: UIViewController {
    var presenter: MainViewPresenter!
    
    // MARK: UI elements
    private lazy var ticketsCollectionView: UICollectionView = {
        let view = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        
        view.dataSource = self
        view.delegate = self
        view.register(TicketsCollectionViewCell.self, forCellWithReuseIdentifier: "Tickets")
        view.backgroundColor = .link
        view.isHidden = true
        view.alpha = 0
        view.toAutoLayout()
        
        return view
    }()
    
    private lazy var loadingIndicator: UIActivityIndicatorView = {
        let view = UIActivityIndicatorView(style: .large)
        
        view.toAutoLayout()
        view.color = .white
        view.startAnimating()
        
        return view
    }()
    
    // MARK: Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .link
        view.addSubViews([ticketsCollectionView,
                          loadingIndicator])
        setNavigationBar()
        setSubViewsLayout()
        presenter.getTicketsCollection()
    }
    
    override func viewWillLayoutSubviews() {
        super.viewDidLayoutSubviews()
        ticketsCollectionView.collectionViewLayout.invalidateLayout()
    }
}

// MARK: Sub functions
extension MainViewController {
    private func setNavigationBar() {
        title = "Сегодня"
        
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.barStyle = .black
        navigationController?.navigationBar.barTintColor = .link
        navigationController?.navigationBar.titleTextAttributes = [ .foregroundColor: UIColor.white ]
    }
    
    private func setSubViewsLayout() {
        let safeArea = view.safeAreaLayoutGuide
        let topBottomOffset: CGFloat = 10
        
        NSLayoutConstraint.activate([
            ticketsCollectionView.topAnchor.constraint(equalTo: safeArea.topAnchor, constant: topBottomOffset),
            ticketsCollectionView.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor, constant: -topBottomOffset),
            ticketsCollectionView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor),
            ticketsCollectionView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor)
        ])
        
        NSLayoutConstraint.activate([
            loadingIndicator.centerXAnchor.constraint(equalTo: safeArea.centerXAnchor),
            loadingIndicator.centerYAnchor.constraint(equalTo: safeArea.centerYAnchor)
        ])
    }
}

// MARK: Collection View DataSource
extension MainViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        presenter.getTicketsCollectionCount()
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Tickets", for: indexPath) as? TicketsCollectionViewCell else {
            return UICollectionViewCell()
        }
        
        cell.setCellData(by: presenter.getTicket(by: indexPath.item))
        cell.ticket = indexPath.item
        cell.delegate = self
        
        return cell
    }
}

//MARK: Collection View Delegate
extension MainViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        presenter.pushDetailsController(selectedTicket: indexPath.item)
    }

    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        let screenSize = collectionView.bounds
        return CGSize(width: screenSize.width - 20, height: screenSize.height / 3)
    }
}

//MARK: MainView Delegate
extension MainViewController: MainView {
    func show(alert: UIAlertController) {
        reloadTicketsCollection()
        present(alert, animated: true)
    }
    
    func reloadTicketsCollection() {
        ticketsCollectionView.reloadData()
        let animation: () -> Void = {
            self.ticketsCollectionView.alpha = 1
        }
        
        self.loadingIndicator.isHidden = true
        self.ticketsCollectionView.isHidden = false
        UIView.animate(withDuration: 0.5, animations: animation, completion: nil)
    }
}

//MARK: TicketCell delegate
extension MainViewController: CellButtonDelegate {
    func setLikeState(of ticket: Int) {
        presenter.setLikeState(of: ticket)
    }
}

//MARK: AdaptivePresentationController delegate
extension MainViewController {
    func presentationControllerDidDismiss(_ presentationController: UIPresentationController) {
        ticketsCollectionView.reloadData()
    }
}
