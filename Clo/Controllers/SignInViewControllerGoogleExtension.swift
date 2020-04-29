import Foundation
import GoogleSignIn
import Firebase

extension SignInViewController:  GIDSignInDelegate{
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {
        if let error = error {
            print("Failed to login into Google:", error.localizedDescription)
            return
        }
        print("Successfully logged in Google")
        guard let authentication = user.authentication else { return }
        let credential = GoogleAuthProvider.credential(withIDToken: authentication.idToken,
                                                       accessToken: authentication.accessToken)
        Auth.auth().signIn(with: credential) { (user, error) in
            if let error = error {
                print(error.localizedDescription)
                return
            }
            print("Successfully logged in Firebase via Google")
        }
    }
}
