import Foundation
import Firebase

class FirebaseManager {

    static let shared = FirebaseManager()
    private init() {}

    func signIn(email: String, password: String, completion: @escaping (Error) -> Void) {
        Auth.auth().signIn(withEmail: email, password: password) { (user, error) in
            if let error = error {
                completion(error)
            }
            guard let user = user?.user else { return }
            print("Log In", user.uid)
        }
    }

    func forgotPassword(email: String, targetVC: UIViewController) {
        Auth.auth().sendPasswordReset(withEmail: email) { (error) in
            DispatchQueue.main.async {
                let resultMessage: String

                if let error = error {
                    resultMessage = error.localizedDescription
                } else {
                    resultMessage = NSLocalizedString("We sent you instruction on your email:", comment: "") + "\n" + "\(email)"
                }
                AlertManager.presentAlert(title: NSLocalizedString("Reset password", comment: ""),
                                          message: resultMessage,
                                          targetVC: targetVC)
            }
        }
    }

    func createUserWithEmail(email: String, password: String, completion: @escaping (Error) -> Void) {
        Auth.auth().createUser(withEmail: email, password: password) { (user, error) in
            if let error = error {
                completion(error)
            }
            guard let user = user?.user else { return }
            print("Success", user.uid)
        }
    }
}
