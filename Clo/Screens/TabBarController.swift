import UIKit
import FittedSheets

class TabBarController: UITabBarController, UITabBarControllerDelegate {
    
    // MARK: - Properties
    private var gallerySheet: SheetViewController!
    private var galleryViewController: GalleryViewController!
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        createTabs()
        setupView()
    }
    
    // MARK: - Functions
    private func setupView() {
        tabBar.barTintColor      = Colors.whiteBGColor
        tabBar.tintColor         = Colors.mintColor
        selectedIndex            = 1
        tabBar.layer.borderWidth = 0.5
        tabBar.layer.borderColor = UIColor.lightGray.cgColor
        delegate                 = self
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
        let height                                = view.frame.size.height * 2 / 3
        galleryViewController                     = GalleryViewController()
        gallerySheet                              = SheetViewController(controller: galleryViewController, sizes: [.fixed(height)])
        gallerySheet.extendBackgroundBehindHandle = true
        gallerySheet.adjustForBottomSafeArea      = true
        gallerySheet.blurBottomSafeArea           = true
        gallerySheet.topCornersRadius             = 15
        gallerySheet.overlayColor                 = Colors.overlayColor
    }
    
    private func handleDismiss() {
        gallerySheet.didDismiss = { [unowned self] _ in
            self.galleryViewController.photoLibraryManager.runRequesting = false
            self.gallerySheet = nil
        }
    }
    
    // MARK: - Delegates
    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        if tabBarController.customizableViewControllers?.firstIndex(of: viewController) == 2 {
            setupGallerySheet()
            present(gallerySheet, animated: false)
            handleDismiss()
            return false
        } else {
            return true
        }
    }
}
