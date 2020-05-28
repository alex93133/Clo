import UIKit
import FirebaseAuth

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.windowScene = windowScene
        if Auth.auth().currentUser == nil {
            window?.rootViewController = UINavigationController(rootViewController: SignInViewController())
        } else {
            window?.rootViewController = GalleryViewController()
            window?.rootViewController = TabBarController()
        }
        window?.makeKeyAndVisible()
    }
}
