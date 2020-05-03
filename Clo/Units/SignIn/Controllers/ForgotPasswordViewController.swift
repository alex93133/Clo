import UIKit

class ForgotPasswordViewController: UIViewController {
    
    // MARK: - Properties
    private let customView = AuthView(frame: UIScreen.main.bounds)
    private var topAnchor: NSLayoutConstraint!
    
    // MARK: - Lifecycle
    override func loadView() {
        setupView()
    }
    
    // MARK: - Functions
    private func view() -> AuthView {
        return view as! AuthView
    }
    
    private func setupView() {
        view                                        =  customView
        view().headLabel.text                       = "Forgot password?"
        view().messageLabel.text                    = "to recover your password enter your email"
        view().passwordTextField.isHidden           = true
        view().reEnterPasswordTextField.isHidden    = true
        view().forgotPasswordButton.isHidden        = true
        view().signUpButton.isHidden                = true
        view().customLoginButtonsStackView.isHidden = true
        view().nextButton.setTitle("Continue", for: .normal)
        view().buttonHandler = { [unowned self] in
            self.forgotPasswordButtonPressed()
        }
    }
    
    private func checkFields() throws {
        guard let email = view().emailTextField.text,
            !email.isEmpty
            else { throw TextFieldErrorHandler.emptyFields }
        guard email.isValidEmail else { throw TextFieldErrorHandler.invalidEmail }
    }
}

// MARK: - Actions
extension ForgotPasswordViewController{
    func forgotPasswordButtonPressed() {
        view().errorLabel.alpha = 0
        do {
            try checkFields()
            FirebaseManager.shared.forgotPassword(email: view().emailTextField.text!, targetVC: self)
        } catch let error {
            view().displayError(errorText: error.localizedDescription)
        }
    }
}
