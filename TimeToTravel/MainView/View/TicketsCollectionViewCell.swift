import UIKit

protocol TicketsCellDelegate: AnyObject {
    func setLikeState(of ticket: Int)
}

// MARK: Cell properties
class TicketsCollectionViewCell: UICollectionViewCell {
    //MARK: UI Propereties
    lazy var route: UILabel = {
        let view = UILabel()
        view.toAutoLayout()
        view.tintColor = .black
        return view
    }()
    
    lazy var startDate: UILabel = {
        let view = UILabel()
        view.toAutoLayout()
        view.tintColor = .black
        return view
    }()
    
    lazy var endDate: UILabel = {
        let view = UILabel()
        view.toAutoLayout()
        view.tintColor = .black
        return view
    }()
    
    lazy var likeButton: UIButton = {
        let view = UIButton()
        view.setImage(UIImage(systemName: "heart"), for: .normal)
        view.tintColor = .red
        view.setTitle("Мне нравится", for: .normal)
        view.setTitleColor(UIColor.black, for: .normal)
        view.toAutoLayout()
        view.addTarget(self, action: #selector(likeButtonTapped(_:)), for: .touchUpInside)
        return view
    }()
    
    lazy var stackView: UIStackView = {
        let view = UIStackView()
        view.axis = .vertical
        view.distribution = .fillEqually
        view.alignment = .fill
        view.toAutoLayout()
        
        return view
    }()
    
    //MARK: Stored properties
    var ticket: Int!
    weak var delegate: TicketsCellDelegate?
    private var isLiked: Bool = false
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .white
        layer.cornerRadius = 10
        addSubview(stackView)
        setStackView()
        setSubViewsLayout()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
}

// MARK: Sub functions
extension TicketsCollectionViewCell {
    private func setStackView() {
        let routeStack = createHorizontalStackView(with: [route], title: "Маршрут:")
        let startDateStack = createHorizontalStackView(with: [startDate], title: "Дата вылета:")
        let endDateStack = createHorizontalStackView(with: [endDate], title: "Дата прилета:")
        
        stackView.addArrangedSubViews([
            routeStack,
            startDateStack,
            endDateStack,
            likeButton
        ])
    }
    
    private func setSubViewsLayout() {
        let offset: CGFloat = 5
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: offset),
            stackView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -offset),
            stackView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: offset),
            stackView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -offset),
        ])
    }
    
    private func createHorizontalStackView(with subViews: [UIView], title: String) -> UIStackView {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .equalSpacing
        stackView.alignment = .fill
        
        let titleLabel = UILabel()
        titleLabel.text = title
        titleLabel.tintColor = .black
        
        stackView.addArrangedSubview(titleLabel)
        stackView.addArrangedSubViews(subViews)
        
        return stackView
    }
    
    func setCellData(by ticket: Ticket) {
        route.text = "\(ticket.startCityCode.uppercased()) - \(ticket.endCityCode.uppercased())"
        startDate.text = ticket.startDate.formatted(date: .abbreviated, time: .shortened)
        endDate.text = ticket.endDate.formatted(date: .abbreviated, time: .shortened)
        isLiked = ticket.isLiked
        setLikeButtonState()
    }
    
    func setLikeButtonState() {
        if isLiked {
            likeButton.setImage(UIImage(systemName: "heart.fill"), for: .normal)
        } else {
            likeButton.setImage(UIImage(systemName: "heart"), for: .normal)
        }
    }
}

// MARK: Actions
extension TicketsCollectionViewCell {
    @objc private func likeButtonTapped(_ sender: UIButton) {
        isLiked = !isLiked
        setLikeButtonState()
        delegate?.setLikeState(of: ticket)
    }
}
