import UIKit

class SignUpViewController: UIViewController {

//    @IBOutlet weak var emailTextField: UITextField!
//    @IBOutlet weak var passwordTextField: UITextField!
//    @IBOutlet weak var repeatPasswordTextField: UITextField!
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//
//    }
//
//    private func register() throws {
//        guard let email = emailTextField.text,
//            let password = passwordTextField.text,
//            let repeatPassword = repeatPasswordTextField.text,
//            !email.isEmpty,
//            !password.isEmpty,
//            !repeatPassword.isEmpty
//        else {
//            throw ErrorHandler.emptyFields
//        }
//        guard password == repeatPassword else { throw ErrorHandler.passwordAreNotSimilar }
//        guard email.isValidEmail else { throw ErrorHandler.invalidEmail }
//        FirebaseManager.shared.createUserWithEmail(email: email, password: password) { (error) in
//            print(error.localizedDescription)
//        }
//    }
//
//    @IBAction func signUp(_ sender: UIButton) {
//        do {
//            try register()
//        } catch let error {
//            print(error.localizedDescription)
//        }
//    }
}
