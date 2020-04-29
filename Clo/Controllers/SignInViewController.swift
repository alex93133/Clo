import UIKit
import GoogleSignIn
import AuthenticationServices

class SignInViewController: UIViewController {
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    
    var currentNonce: String?
    private lazy var appleLogInButton : ASAuthorizationAppleIDButton = {
        let button = ASAuthorizationAppleIDButton()
        button.frame = CGRect(x: 0, y: 0, width: 200, height: 50)
        button.center = CGPoint(x: view.frame.width / 2, y: view.frame.height / 2 + 100)
        button.addTarget(self, action: #selector(handleLogInWithAppleID), for: .touchUpInside)
        return button
    }()
  
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    private func setup() {
        GIDSignIn.sharedInstance().delegate                  = self
        GIDSignIn.sharedInstance()?.presentingViewController = self
        view.addSubview(appleLogInButton)
    }
    
    private func signInWithEmail() throws {
        guard let email = emailTextField.text,
            let password = passwordTextField.text,
            !email.isEmpty,
            !password.isEmpty
            else {
                throw ErrorHandler.emptyFields
        }
        guard email.isValidEmail else { throw ErrorHandler.invalidEmail }
        FirebaseManager.shared.signIn(email: email, password: password) { (error) in
            print(error.localizedDescription)
        }
    }
    
    private func forgotPassword() throws {
        guard let email = emailTextField.text,
            !email.isEmpty
            else {
                throw ErrorHandler.emptyFields
        }
        FirebaseManager.shared.forgotPassword(email: email, targetVC: self)
    }
    
    
    @IBAction func forgotPasswordButtonPressed(_ sender: UIButton) {
        do {
            try forgotPassword()
        } catch let error {
            print(error.localizedDescription)
        }
    }
    
    @IBAction func signInWithEmailButtonPressed(_ sender: UIButton) {
        do {
            try signInWithEmail()
        } catch let error {
            print(error.localizedDescription)
        }
    }

    @IBAction func signInWithGoogleButtonPressed(_ sender: UIButton) {
        GIDSignIn.sharedInstance()?.signIn()
    }
}



