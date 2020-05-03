import UIKit

class AlertManager {

    static func presentAlert (title: String, message: String, closeButton: String = "Close", targetVC: UIViewController, handler: ((UIAlertAction) -> Void)? = nil ) {
        let alert      = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let closeAlert = UIAlertAction(title: closeButton, style: .cancel, handler: handler)
        alert.addAction(closeAlert)
        targetVC.present(alert, animated: true, completion: nil)
    }
}
