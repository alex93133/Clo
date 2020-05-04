import UIKit

class SignUpViewController: UIViewController {

    // MARK: - Properties
    private let customView = AuthView(frame: UIScreen.main.bounds)

    // MARK: - Lifecycle
    override func loadView() {
        setupView()
    }

    // MARK: - Functions
    private func view() -> AuthView {
        return view as! AuthView
    }

    private func setupView() {
        view                                 = customView
        view().headLabel.text                = "Create account"
        view().messageLabel.text             = "or sign up with email"
        view().forgotPasswordButton.isHidden = true
        view().signUpButton.isHidden         = true
        view().nextButton.setTitle("Create account", for: .normal)
        view().buttonHandler = { [unowned self] in
            self.createAccountButtonPressed()
        }
    }

    private func checkFields() throws {
        guard let email = view().emailTextField.text,
            let password = view().passwordTextField.text,
            let reEnterPassword = view().reEnterPasswordTextField.text,
            !email.isEmpty,
            !password.isEmpty,
            !reEnterPassword.isEmpty
            else { throw TextFieldErrorHandler.emptyFields }
        guard password == reEnterPassword else { throw TextFieldErrorHandler.passwordAreNotSimilar }
        guard email.isValidEmail else { throw TextFieldErrorHandler.invalidEmail }
    }
}

// MARK: - Actions
extension SignUpViewController {

    func createAccountButtonPressed() {
        view().errorLabel.alpha = 0
        do {
            try checkFields()
            view().processing(isProcessing: true)
            FirebaseManager.shared.createUserWithEmail(email: view().emailTextField.text!,
                                                       password: view().passwordTextField.text!) { [unowned self] (response) in
                                                        self.view().processing(isProcessing: false)

                                                        switch response {
                                                        case .success:
                                                            Router.signIn(from: self)
                                                        case .failure(errorString: let errorString):
                                                            self.view().displayError(errorText: errorString)
                                                        }
            }
        } catch let error {
            view().displayError(errorText: error.localizedDescription)
        }
    }
}
