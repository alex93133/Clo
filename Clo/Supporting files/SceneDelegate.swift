import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo _: UISceneSession, options _: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        window                     = UIWindow(frame: UIScreen.main.bounds)
        window?.windowScene        = windowScene
        window?.rootViewController = MainTabBarController()
        window?.makeKeyAndVisible()
    }
}
