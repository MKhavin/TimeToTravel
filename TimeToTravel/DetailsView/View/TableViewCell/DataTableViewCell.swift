import UIKit

class DataTableViewCell: UITableViewCell {

    func set(data: String) {
        backgroundColor = .white
        
        var config = defaultContentConfiguration()
        config.text = data
        config.textProperties.color = .black
        contentConfiguration = config
    }

}
