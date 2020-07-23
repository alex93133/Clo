import AVFoundation
import Photos
import UIKit

class MainTabBarController: UITabBarController, UITabBarControllerDelegate {

    // MARK: - Properties
    private var imageToPass: UIImage?
    private var laundrySymbolsViewController: LaundrySymbolsViewController!
    private var laundryListViewController: LaundryListViewController!
    private var clothesListViewController: ClothesListViewController!
    private var menuViewController: MenuViewController!

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        createTabs()
        setupView()
        setupDependencies()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        selectedIndex = 2
    }

    // MARK: - Functions
    private func setupView() {
        tabBar.barTintColor            = Colors.mainBG
        tabBar.tintColor               = Colors.mint
        tabBar.unselectedItemTintColor = Colors.icon
        tabBar.isTranslucent           = false
        tabBar.layer.borderColor       = UIColor.lightGray.cgColor
        delegate                       = self
    }

    private func createTabs() {
        laundrySymbolsViewController = LaundrySymbolsViewController()
        laundryListViewController    = LaundryListViewController()
        clothesListViewController    = ClothesListViewController()
        menuViewController           = MenuViewController()

        let item1        = UINavigationController(rootViewController: laundrySymbolsViewController)
        let icon1        = UITabBarItem(title: "", image: Images.questionIcon, tag: 1)
        item1.tabBarItem = icon1

        let item2        = UINavigationController(rootViewController: laundryListViewController)
        let icon2        = UITabBarItem(title: "", image: Images.machineIcon, tag: 2)
        item2.tabBarItem = icon2

        let item3        = UINavigationController(rootViewController: clothesListViewController)
        let icon3        = UITabBarItem(title: "", image: Images.clothesIcon, tag: 3)
        item3.tabBarItem = icon3

        let item4        = UIViewController()
        let icon4        = UITabBarItem(title: "", image: Images.addIcon, tag: 4)
        item4.tabBarItem = icon4

        let item5        = menuViewController!
        let icon5        = UITabBarItem(title: "", image: Images.menuIcon, tag: 5)
        item5.tabBarItem = icon5

        let controllers  = [item1, item2, item3, item4, item5]
        viewControllers  = controllers
    }

    private func setupDependencies() {
        clothesListViewController.presentPhotoSheet = { [weak self] in
            guard let self = self else { return }
            self.presentPhotoSheet()
        }
    }

    private func presentPhotoSheet() {
        let gallerySheet = GallerySheet(height: view.frame.size.height * 2 / 3)

        gallerySheet.gallery.cropViewControllerHandler = { [weak self] image in
            guard let self = self else { return }
            self.imageToPass = image
        }
        gallerySheet.sheet.didDismiss = { [weak self] _ in
            guard let self = self else { return }
            guard let image = self.imageToPass else { return }
            self.presentAddEditClothesViewController(image: image)
            self.imageToPass = nil
        }
        present(gallerySheet.sheet, animated: false)
    }

    private func presentAddEditClothesViewController(image: UIImage) {
        let addClothesViewController                = AddEditClothesViewController(image: image)
        let navigationController                    = UINavigationController(rootViewController: addClothesViewController)
        navigationController.modalPresentationStyle = .fullScreen
        present(navigationController, animated: true) {
            FeedbackManager.heavy()
        }
    }

    private func presentViewWithWarning() {
        let alert = CloAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        NSLayoutConstraint.activate([alert.view.heightAnchor.constraint(equalToConstant: 330)])

        let cancelAction = UIAlertAction(title: NSLocalizedString("Maybe later", comment: ""), style: .cancel)
        alert.addAction(cancelAction)
        let getAccessAction = UIAlertAction(title: NSLocalizedString("Get access", comment: ""), style: .default) { _ in
            PhotoLibraryManager.getAccess { [weak self] result in
                guard let self = self else { return }
                switch result {
                case .accessed:
                    self.presentPhotoSheet()

                case .denied:
                    return
                }
            }
        }
        alert.addAction(getAccessAction)

        present(alert, animated: true)

        alert.imageView.image   = Images.cameraIcon
        alert.headLabel.text    = NSLocalizedString("Please note", comment: "")
        alert.messageLabel.text = NSLocalizedString("For the full application, you will need a smartphone camera. Please allow access", comment: "")
    }

    private func presentViewWithError() {
        let alert = CloAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        NSLayoutConstraint.activate([alert.view.heightAnchor.constraint(equalToConstant: 330)])

        let cancelAction = UIAlertAction(title: NSLocalizedString("Maybe later", comment: ""), style: .cancel)
        alert.addAction(cancelAction)
        let openSettingsAction = UIAlertAction(title: NSLocalizedString("Open Settings", comment: ""), style: .default) { [weak self] _ in
            guard let self = self else { return }
            self.openSettings()
        }
        alert.addAction(openSettingsAction)

        present(alert, animated: true)

        alert.imageView.image   = Images.forbidden
        alert.headLabel.text    = NSLocalizedString("Oops!", comment: "")
        alert.messageLabel.text = NSLocalizedString("Looks like you forgot to turn on the camera. To continue, you'll need to allow camera access in Settings", comment: "")
    }

    private func openSettings() {
        guard let url = URL(string: UIApplication.openSettingsURLString) else {
            return
        }
        if UIApplication.shared.canOpenURL(url) {
            UIApplication.shared.open(url, options: [:])
        }
    }

    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        switch tabBarController.customizableViewControllers?.firstIndex(of: viewController) {
        case 3:
            PhotoLibraryManager.checkAccessStatus { [weak self] result in
                guard let self = self else { return }
                switch result {
                case .allow:
                    FeedbackManager.light()
                    self.presentPhotoSheet()

                case .warning:
                    FeedbackManager.warning()
                    self.presentViewWithWarning()

                case .error:
                    FeedbackManager.error()
                    self.presentViewWithError()
                }
            }
            return false

        default:
            return true
        }
    }
}
