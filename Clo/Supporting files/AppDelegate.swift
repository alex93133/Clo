import CoreData
import IQKeyboardManagerSwift
import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    func application(_: UIApplication, didFinishLaunchingWithOptions _: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        IQKeyboardManager.shared.enable                       = true
        IQKeyboardManager.shared.shouldResignOnTouchOutside   = true
        IQKeyboardManager.shared.shouldShowToolbarPlaceholder = false

        //        Color of items
        UIBarButtonItem.appearance().tintColor                        = Colors.mint
        //        Setting back image
        UINavigationBar.appearance().backIndicatorImage               = Images.backIcon
        UINavigationBar.appearance().backIndicatorTransitionMaskImage = Images.backIcon
        // Removing separator
        UINavigationBar.appearance().shadowImage                      = UIImage()
        // Removing back image text for 2 states
        UIBarButtonItem.appearance().setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.clear], for: .normal)
        UIBarButtonItem.appearance().setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.clear], for: UIControl.State.highlighted)
        //        Disable transparent
        UINavigationBar.appearance().isTranslucent                    = false
        // Font and text color for title
        UINavigationBar.appearance().titleTextAttributes              = [
            NSAttributedString.Key.foregroundColor: Colors.accent,
            NSAttributedString.Key.font: UIFont.systemFont(ofSize: Constants.Fonts.headTextSize, weight: .bold)
        ]
        UINavigationBar.appearance().barTintColor                     = Colors.mainBG

        Bundle(path: "/Applications/InjectionIII.app/Contents/Resources/iOSInjection.bundle")?.load()

        return true
    }

    // MARK: - Core Data stack
    lazy var persistentContainer: NSPersistentCloudKitContainer = {
        let container = NSPersistentCloudKitContainer(name: "Clothes")
        container.loadPersistentStores { _, error in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        }
        return container
    }()

    // MARK: - Core Data Saving support
    func saveContext() -> Result<Error> {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
                return Result.success
            } catch {
                let nserror = error as NSError
                return Result.failure(nserror)
            }
        }
        return Result.success
    }
}
