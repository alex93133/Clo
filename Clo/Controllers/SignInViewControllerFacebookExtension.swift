import Foundation
import FacebookLogin
import Firebase

extension SignInViewController: LoginButtonDelegate {
    func loginButton(_ loginButton: FBLoginButton, didCompleteWith result: LoginManagerLoginResult?, error: Error?) {
        if let error = error {
            print("Failed to login into Facebook:", error.localizedDescription)
            return
        }
        guard AccessToken.isCurrentAccessTokenActive else { return }
        print("Successfully logged in Facebook")
        let credential = FacebookAuthProvider.credential(withAccessToken: AccessToken.current!.tokenString)
        Auth.auth().signIn(with: credential) { (_, error) in
            if let error = error {
                print(error.localizedDescription)
                return
            }
            print("Successfully logged in Firebase via Facebook")
        }
    }

    func loginButtonDidLogOut(_ loginButton: FBLoginButton) {
        print("Logout from Facebook")
    }
}
