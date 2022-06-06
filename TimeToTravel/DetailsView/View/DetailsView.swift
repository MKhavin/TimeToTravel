import UIKit

class DetailView: UIView {
    enum CellIdentifiers: String, CaseIterable {
        case ticketData = "TicketData"
        case likeButton = "LikeButton"
    }
    
    private let cornerRadius: CGFloat = 20
    
    lazy var routeLabel: UILabel = {
        let view = UILabel()
       
        view.toAutoLayout()
        view.textAlignment = .center
        view.font = .systemFont(ofSize: 20, weight: .bold)
        view.textColor = .black
        
        return view
    }()
    
    lazy var tableView: UITableView = {
        let view = UITableView()
        
        view.separatorStyle = .none
        view.toAutoLayout()
        view.register(DataTableViewCell.self, forCellReuseIdentifier: CellIdentifiers.ticketData.rawValue)
        view.register(ButtonTableViewCell.self, forCellReuseIdentifier: CellIdentifiers.likeButton.rawValue)
        view.layer.cornerRadius = self.cornerRadius
        view.allowsSelection = false
        view.backgroundColor = .white
        
        return view
    }()
    
    lazy var likeButton: UIButton = {
        let view = UIButton()
        
        view.setTitle("Мне нравится", for: .normal)
        view.setTitleColor(UIColor.black, for: .normal)
        view.toAutoLayout()
        
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        layer.cornerRadius = cornerRadius
        backgroundColor = .white
        addSubViews([
            routeLabel,
            tableView
        ])
        setSubViewsLayout()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
}

//MARK: Sub functions
extension DetailView {
    func setSubViewsLayout() {
        NSLayoutConstraint.activate([
            routeLabel.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            routeLabel.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
            routeLabel.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor),
            routeLabel.heightAnchor.constraint(equalToConstant: 40)
        ])
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: routeLabel.bottomAnchor, constant: 5),
            tableView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor)
        ])
    }
}
