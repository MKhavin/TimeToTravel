import UIKit

class DetailView: UIView {
    enum CellIdentifier: String, CaseIterable {
        case ticketData = "TicketData"
        case likeButton = "LikeButton"
    }
    
    private enum Constant {
        static let cornerRadius: CGFloat = 20
        static let titleSize: CGFloat = 20
        static let titleHeight: CGFloat = 40
        static let tableOffset: CGFloat = 5
    }
    
    // MARK: UI elements
    lazy var routeLabel: UILabel = {
        let view = UILabel()
       
        view.toAutoLayout()
        view.textAlignment = .center
        view.font = .systemFont(ofSize: Constant.titleSize, weight: .bold)
        view.textColor = .black
        
        return view
    }()
    
    lazy var tableView: UITableView = {
        let view = UITableView()
        
        view.separatorStyle = .none
        view.toAutoLayout()
        view.register(DataTableViewCell.self, forCellReuseIdentifier: CellIdentifier.ticketData.rawValue)
        view.register(ButtonTableViewCell.self, forCellReuseIdentifier: CellIdentifier.likeButton.rawValue)
        view.layer.cornerRadius = Constant.cornerRadius
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
   
    //MARK: Life cycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        layer.cornerRadius = Constant.cornerRadius
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
            routeLabel.heightAnchor.constraint(equalToConstant: Constant.titleHeight)
        ])
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: routeLabel.bottomAnchor, constant: Constant.tableOffset),
            tableView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor)
        ])
    }
}
