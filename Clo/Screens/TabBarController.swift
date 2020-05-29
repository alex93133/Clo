import UIKit
import FittedSheets

class TabBarController: UITabBarController, UITabBarControllerDelegate {

    // MARK: - Properties
    var gallerySheet: SheetViewController!

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        delegate = self
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        createTabs()
        setupView()
        setupGallerySheet()
    }

    // MARK: - Functions
    private func setupView() {
        tabBar.barTintColor      = Colors.whiteBGColor
        tabBar.tintColor         = Colors.mintColor
        selectedIndex            = 1
        tabBar.layer.borderWidth = 0.5
        tabBar.layer.borderColor = UIColor.lightGray.cgColor
    }

    private func createTabs() {

        let item1 = UINavigationController(rootViewController: LaundrySymbolsViewController())
        let icon1 = UITabBarItem(title: "", image: Images.questionIcon, tag: 1)
        item1.tabBarItem = icon1

        let item2 = UINavigationController(rootViewController: ClothesListViewController())
        let icon2 = UITabBarItem(title: "", image: Images.clothesIcon, tag: 2)
        item2.tabBarItem = icon2

        let item3 = UIViewController()
        let icon3 = UITabBarItem(title: "", image: Images.addIcon, tag: 3)
        item3.tabBarItem = icon3

        let controllers = [item1, item2, item3]
        viewControllers = controllers
    }

    private func setupGallerySheet() {
        let height                         = view.frame.size.height * 2 / 3
        let galleryViewController          = GalleryViewController()
        let sheet                          = SheetViewController(controller: galleryViewController, sizes: [.fixed(height)])
        sheet.extendBackgroundBehindHandle = true
        sheet.adjustForBottomSafeArea      = true
        sheet.blurBottomSafeArea           = true
        sheet.topCornersRadius             = 15
        sheet.overlayColor                 = Colors.overlayColor
        gallerySheet                       = sheet
    }

    private func handleDismiss() {
        gallerySheet.didDismiss = { _ in
            #warning("Обработать")
        }
    }

    // MARK: - Delegates
    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        if tabBarController.customizableViewControllers?.firstIndex(of: viewController) == 2 {
            present(gallerySheet, animated: false)
            return false
        } else {
            return true
        }
    }
}
