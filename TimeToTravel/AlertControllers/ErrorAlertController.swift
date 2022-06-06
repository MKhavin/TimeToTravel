import UIKit

class ErrorAlertController: UIAlertController {
    override func viewDidLoad() {
        super.viewDidLoad()

        let action = UIAlertAction(title: "OK", style: .default) { action in
            self.dismiss(animated: true)
        }
        addAction(action)
    }
}
