import UIKit

protocol MainView: AnyObject {
    func reloadTicketsCollection()
}

class MainViewController: UIViewController {
    var presenter: MainViewPresenter!
    
    private lazy var ticketsCollectionView: UICollectionView = {
        let view = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        view.dataSource = self
        view.delegate = self
        view.register(TicketsCollectionViewCell.self, forCellWithReuseIdentifier: "Tickets")
        view.backgroundColor = .link
        view.toAutoLayout()
        view.isHidden = true
        view.alpha = 0
        return view
    }()
    
    private lazy var loadingIndicator: UIActivityIndicatorView = {
        let view = UIActivityIndicatorView(style: .large)
        view.toAutoLayout()
        view.tintColor = .white
        view.startAnimating()
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .link
        view.addSubViews([ticketsCollectionView,
                          loadingIndicator])
        setNavigationBar()
        setSubViewsLayout()
        presenter.getTicketsCollection()
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
        
        NSLayoutConstraint.activate([
            ticketsCollectionView.topAnchor.constraint(equalTo: safeArea.topAnchor, constant: 10),
            ticketsCollectionView.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor, constant: -10),
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
        presenter.tickets.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Tickets", for: indexPath) as? TicketsCollectionViewCell else {
            return UICollectionViewCell()
        }
        
        cell.setCellData(by: presenter.tickets[indexPath.item])
        return cell
    }
}

//MARK: Collection View Delegate
extension MainViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        present(UIViewController(), animated: true)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let screenSize = UIScreen.main.bounds
        return CGSize(width: screenSize.width - 20, height: screenSize.height / 4)
    }
}

//MARK: MainView Delegate
extension MainViewController: MainView {
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
