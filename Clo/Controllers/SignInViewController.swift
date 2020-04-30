import UIKit
import GoogleSignIn
import AuthenticationServices
import FacebookLogin

class SignInViewController: UIViewController {

    // MARK: - Properties
    var currentNonce: String?

    var logoLabel: UILabel!
    var loginLabel: UILabel!
    var messageLabel: UILabel!
    var emailTextField: UITextField!
    var passwordTextField: UITextField!
    var appleLoginButton: ASAuthorizationAppleIDButton!
    var googleLoginButton: UIButton!
    var fbLoginButton: UIButton!
    var forgotPasswordButton: UIButton!
    var signInButton: UIButton!
    var signUpButton: UIButton!
    var activityIndicator: UIActivityIndicatorView!

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }

    // MARK: - Functions
    private func signInWithEmail() throws {
        guard let email = emailTextField.text,
            let password = passwordTextField.text,
            !email.isEmpty,
            !password.isEmpty
            else {
                throw ErrorHandler.emptyFields
        }
        guard email.isValidEmail else { throw ErrorHandler.invalidEmail }

        activityIndicator.startAnimating()
        signInButton.isEnabled = false
        signInButton.alpha = 1.0

        FirebaseManager.shared.signIn(email: email, password: password) { [unowned self] (error) in
            self.activityIndicator.stopAnimating()
            self.signInButton.isEnabled = true
            self.signInButton.alpha = 1
            print(error.localizedDescription)
        }
    }

    // MARK: - Actions
    @objc func forgotPasswordButtonPressed() {
        let forgotPasswordViewController = ForgotPasswordViewController()
        navigationController?.pushViewController(forgotPasswordViewController, animated: true)
    }

    @objc func signInWithEmailButtonPressed() {
        do {
            try signInWithEmail()
        } catch let error {
            print(error.localizedDescription)
        }
    }

    @objc func signInWithGoogleButtonPressed() {
        GIDSignIn.sharedInstance()?.signIn()
    }

    @objc func signInWithFacebookButtonPressed() {
        LoginManager().logIn(permissions: ["email", "public_profile"], from: self) { (result, error) in
            if let error = error {
                print(error.localizedDescription)
                return
            }
            guard let result = result else { return }

            if result.isCancelled { return } else {
                print("Login in Facebook")
            }
        }
    }

    @objc func signUp() {
        do {
            try signInWithEmail()
            print("Next")
        } catch let error {
            print(error.localizedDescription)
        }
    }
}
