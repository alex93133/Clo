import UIKit
import Firebase
import GoogleSignIn
import FBSDKCoreKit
import IQKeyboardManagerSwift

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

        IQKeyboardManager.shared.enable = true

        FirebaseApp.configure()
        GIDSignIn.sharedInstance().clientID = FirebaseApp.app()?.options.clientID

        UINavigationBar.appearance().titleTextAttributes              = [NSAttributedString.Key.foregroundColor: Colors.blackTextColor,
                                                                         NSAttributedString.Key.font: UIFont.systemFont(ofSize: Constants.Fonts.navigationBarItemTextSize, weight: .bold)]
        UINavigationBar.appearance().isTranslucent                    = false
        UINavigationBar.appearance().barTintColor                     = Colors.lightGrayBGColor

        UINavigationBar.appearance().backIndicatorImage               = Images.backIcon
        UINavigationBar.appearance().backIndicatorTransitionMaskImage = Images.backIcon

        UIBarButtonItem.appearance().tintColor                        = Colors.mintColor

        UIBarButtonItem.appearance().setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.clear], for: .normal)
        UIBarButtonItem.appearance().setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.clear], for: UIControl.State.highlighted)

        return true
    }

    @available(iOS 9.0, *)
    func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey: Any] = [:]) -> Bool {
        return GIDSignIn.sharedInstance().handle(url)
    }
}
