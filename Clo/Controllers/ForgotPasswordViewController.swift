import UIKit
import Firebase

class ForgotPasswordViewController: UIViewController {

    // MARK: - Properties
    var resetLabel: UILabel!
    var messageLabel: UILabel!
    var emailTextField: UITextField!
    var continueButton: UIButton!

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

        setup()
    }

    // MARK: - Functions
    private func forgotPassword() throws {
        guard let email = emailTextField.text,
            !email.isEmpty
            else {
                throw ErrorHandler.emptyFields
        }
        FirebaseManager.shared.forgotPassword(email: email, targetVC: self)
    }

    // MARK: - Actions
    @objc func forgotPasswordButtonPressed() {
        do {
            try forgotPassword()
        } catch let error {
            print(error.localizedDescription)
        }
    }
}
