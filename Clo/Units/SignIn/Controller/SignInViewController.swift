import UIKit
import GoogleSignIn
import AuthenticationServices
import FacebookLogin
import Firebase

class SignInViewController: UIViewController {

    // MARK: - Properties
    var currentNonce: String?
    let customView = AuthView(frame: UIScreen.main.bounds)

    // MARK: - Lifecycle
    override func viewDidLoad() {
        setupView()
    }

    // MARK: - Functions
    private func view() -> AuthView {
        return view as! AuthView
    }

    private func setupView() {
        view                                                 =  customView
        view().reEnterPasswordTextField.isHidden             = true
        view().delegate                                      = self
        GIDSignIn.sharedInstance().delegate                  = self
        GIDSignIn.sharedInstance()?.presentingViewController = self
        view().buttonHandler = { [unowned self] in
            self.signInWithEmailButtonPressed()
        }
    }

    private func checkFields() throws {
        guard let email = view().emailTextField.text,
            let password = view().passwordTextField.text,
            !email.isEmpty,
            !password.isEmpty
            else {
                throw TextFieldErrorHandler.emptyFields
        }
        guard email.isValidEmail else { throw TextFieldErrorHandler.invalidEmail }
    }
}

// MARK: - Actions
extension SignInViewController: AuthViewDelegate {

    func forgotPasswordButtonPressed() {
        let forgotPasswordViewController = ForgotPasswordViewController()
        navigationController?.pushViewController(forgotPasswordViewController, animated: true)
    }

    func signInWithEmailButtonPressed() {
        view().errorLabel.alpha = 0
        do {
            try checkFields()
            view().processing(isProcessing: true)
            FirebaseManager.shared.signIn(email: view().emailTextField.text!,
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

    func signInWithGoogleButtonPressed() {
        GIDSignIn.sharedInstance()?.signIn()
    }

    func signInWithFacebookButtonPressed() {
        LoginManager().logIn(permissions: ["email", "public_profile"], from: self) { [unowned self] (result, error) in
            if let error = error {
                print(error.localizedDescription)
                return
            }
            guard let result = result,
                !result.isCancelled else { return }
            self.signInWithFBToken()
        }
    }

    func signUpButtonPressed() {
        let signUpViewController = SignUpViewController()
        navigationController?.pushViewController(signUpViewController, animated: true)
    }
}
