import UIKit
import IQKeyboardManagerSwift

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

        IQKeyboardManager.shared.enable = true

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
}
