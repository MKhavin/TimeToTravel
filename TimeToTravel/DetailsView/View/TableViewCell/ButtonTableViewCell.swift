import UIKit

class ButtonTableViewCell: UITableViewCell {

    weak var delegate: DetailsView?
    private var isLiked: Bool = false
    
    lazy var likeButton: UIButton = {
        let view = UIButton()
        
        view.setTitle("Мне нравится", for: .normal)
        view.setTitleColor(UIColor.black, for: .normal)
        view.toAutoLayout()
        view.addTarget(self, action: #selector(likeButtonTapped(_:)), for: .touchUpInside)
        view.tintColor = .red
        
        return view
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        backgroundColor = .white
        contentView.addSubview(likeButton)
        
        NSLayoutConstraint.activate([
            likeButton.topAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.topAnchor),
            likeButton.bottomAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.bottomAnchor),
            likeButton.leadingAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.leadingAnchor),
            likeButton.trailingAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.trailingAnchor),
        ])
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    func setCurrentLike(status: Bool) {
        isLiked = status
        setLikeButtonState()
    }
    
}

// MARK: Sub functions
extension ButtonTableViewCell {
    private func setLikeButtonState() {
        if isLiked {
            likeButton.setImage(UIImage(systemName: "heart.fill"), for: .normal)
        } else {
            likeButton.setImage(UIImage(systemName: "heart"), for: .normal)
        }
    }
}

// MARK: Actions
extension ButtonTableViewCell {
    @objc private func likeButtonTapped(_ sender: UIButton) {
        isLiked = !isLiked
        setLikeButtonState()
        delegate?.setLikeState()
    }
}
