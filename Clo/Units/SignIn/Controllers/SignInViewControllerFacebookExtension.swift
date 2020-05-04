import Foundation
import FacebookLogin
import Firebase

extension SignInViewController: LoginButtonDelegate {

    func loginButton(_ loginButton: FBLoginButton, didCompleteWith result: LoginManagerLoginResult?, error: Error?) {
        if let error = error {
            customView.displayError(errorText: error.localizedDescription)
            return
        }
        signInWithFBToken()
    }

    func signInWithFBToken() {
        guard AccessToken.isCurrentAccessTokenActive else { return }
        let credential = FacebookAuthProvider.credential(withAccessToken: AccessToken.current!.tokenString)

        Auth.auth().signIn(with: credential) { [unowned self] (_, error) in
            if let error = error {
                self.customView.displayError(errorText: error.localizedDescription)
                return
            }
            Router.signIn(from: self)
        }
    }

    func loginButtonDidLogOut(_ loginButton: FBLoginButton) {
        print("Logout from Facebook")
    }
}
