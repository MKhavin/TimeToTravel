import UIKit

protocol CellButtonDelegate: AnyObject {
    func setLikeState(of ticket: Int)
}

class TicketsCollectionViewCell: UICollectionViewCell {
    // MARK: UI Properties
    lazy var route: UILabel = {
        let view = UILabel()
        
        view.toAutoLayout()
        view.textColor = .black
        
        return view
    }()
    
    lazy var startDate: UILabel = {
        let view = UILabel()
        
        view.toAutoLayout()
        view.textColor = .black
        
        return view
    }()
    
    lazy var endDate: UILabel = {
        let view = UILabel()
        
        view.toAutoLayout()
        view.textColor = .black
        
        return view
    }()
    
    lazy var price: UILabel = {
        let view = UILabel()
        
        view.toAutoLayout()
        view.textColor = .black
        
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
    
    // MARK: Stored properties
    var ticket: Int!
    weak var delegate: CellButtonDelegate?
    private var isLiked: Bool = false
    
    // MARK: Life Cycle
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
        let routeStack = createHorizontalStackView(with: route, title: "Маршрут:")
        let startDateStack = createHorizontalStackView(with: startDate, title: "Дата вылета:")
        let endDateStack = createHorizontalStackView(with: endDate, title: "Дата прилета:")
        let priceStack = createHorizontalStackView(with: price, title: "Цена:")
        
        stackView.addArrangedSubViews([
            routeStack,
            startDateStack,
            endDateStack,
            priceStack,
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
    
    private func createHorizontalStackView(with subView: UIView, title: String) -> UIStackView {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .equalSpacing
        stackView.alignment = .fill
        
        let titleLabel = UILabel()
        titleLabel.text = title
        titleLabel.textColor = .black
        
        stackView.addArrangedSubview(titleLabel)
        stackView.addArrangedSubview(subView)
        
        return stackView
    }
    
    func setCellData(by ticket: Ticket) {
        route.text = "\(ticket.startCityCode.uppercased()) - \(ticket.endCityCode.uppercased())"
        price.text = ticket.price.currencyFormatted()
        
        let dateFormat = "d MMMM yyyy HH:mm"
        startDate.text = ticket.startDate.formatted(dateFormat: dateFormat)
        endDate.text = ticket.endDate.formatted(dateFormat: dateFormat)
        
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
