import UIKit

class SignInViewController: UIViewController {
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
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
}
