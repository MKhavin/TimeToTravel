import UIKit

extension UIView {
    func addSubViews(_ subViews: [UIView]) {
        subViews.forEach { view in
            self.addSubview(view)
        }
    }
    
    func toAutoLayout() {
        self.translatesAutoresizingMaskIntoConstraints = false
    }
}
