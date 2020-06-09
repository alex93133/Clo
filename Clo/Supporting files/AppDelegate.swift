import UIKit
import IQKeyboardManagerSwift
import CoreData

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

    // MARK: - Core Data stack
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "Clothes")
        container.loadPersistentStores(completionHandler: { (_, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()

    // MARK: - Core Data Saving support
    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
}
