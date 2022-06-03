import UIKit

extension UIStackView {
    func addArrangedSubViews(_ subViews: [UIView]) {
        subViews.forEach { view in
            self.addArrangedSubview(view)
        }
    }
}
