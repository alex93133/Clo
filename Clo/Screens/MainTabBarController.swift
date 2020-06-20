import AVFoundation
import Photos
import UIKit

class MainTabBarController: UITabBarController, UITabBarControllerDelegate {
    
    // MARK: - Properties
    private var imageToPass: UIImage?

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        createTabs()
        setupView()
    }

    // MARK: - Functions
    private func setupView() {
        tabBar.barTintColor            = Colors.mainBG
        tabBar.tintColor               = Colors.mint
        tabBar.unselectedItemTintColor = Colors.icon
        tabBar.isTranslucent           = false
        selectedIndex                  = 2
        tabBar.layer.borderColor       = UIColor.lightGray.cgColor
        delegate                       = self
    }

    private func createTabs() {
        let item1        = UINavigationController(rootViewController: LaundrySymbolsViewController())
        let icon1        = UITabBarItem(title: "", image: Images.questionIcon, tag: 1)
        item1.tabBarItem = icon1

        let item2        = UIViewController()
        let icon2        = UITabBarItem(title: "", image: Images.machineIcon, tag: 2)
        item2.tabBarItem = icon2

        let clothesListViewController      = ClothesListViewController()
        clothesListViewController.delegate = self
        
        let item3        = UINavigationController(rootViewController: clothesListViewController)
        let icon3        = UITabBarItem(title: "", image: Images.clothesIcon, tag: 3)
        item3.tabBarItem = icon3

        let item4        = UIViewController()
        let icon4        = UITabBarItem(title: "", image: Images.addIcon, tag: 4)
        item4.tabBarItem = icon4

        let item5        = UIViewController()
        let icon5        = UITabBarItem(title: "", image: Images.menuIcon, tag: 5)
        item5.tabBarItem = icon5

        let controllers  = [item1, item2, item3, item4, item5]
        viewControllers  = controllers
    }

    private func presentSheetViewController() {
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
        let addClothesViewController = AddEditClothesViewController(image: image)
        let navigationController = UINavigationController(rootViewController: addClothesViewController)
        navigationController.modalPresentationStyle = .fullScreen
        present(navigationController, animated: true)
    }

    private func presentViewWithWarning() {
        let alert = CustomAlertController(title: nil, message: nil, preferredStyle: .actionSheet)

        let cancelAction = UIAlertAction(title: "Maybe later", style: .cancel)
        alert.addAction(cancelAction)
        let getAccessAction = UIAlertAction(title: "Get access", style: .default) { _ in
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
        alert.headLabel.text    = "Please note"
        alert.messageLabel.text = "For the full application, you will need a smartphone camera. Please allow access"
    }

    private func presentViewWithError() {
        let alert = CustomAlertController(title: nil, message: nil, preferredStyle: .actionSheet)

        let cancelAction = UIAlertAction(title: "Maybe later", style: .cancel)
        alert.addAction(cancelAction)
        let openSettingsAction = UIAlertAction(title: "Open Settings", style: .default) { [weak self] _ in
            guard let self = self else { return }
            self.openSettings()
        }
        alert.addAction(openSettingsAction)

        present(alert, animated: true)

        alert.imageView.image   = Images.forbidden
        alert.headLabel.text    = "Oops!"
        alert.messageLabel.text = "Looks like you forgot to turn on the camera. To continue, you'll need to allow camera access in Settings"
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
        case 1:
            print("Machine")
            return false
        case 4:
            print("Menu")
            return false
        case 3:
            PhotoLibraryManager.checkAccessStatus { [weak self] result in
                guard let self = self else { return }
                switch result {
                case .allow:
                    self.presentPhotoSheet()
                case .warning:
                    self.presentViewWithWarning()
                case .error:
                    self.presentViewWithError()
                }
            }
            return false
        default: return true
        }
    }
}

extension MainTabBarController: ClothesListViewControllerDelegate {
   
    func presentPhotoSheet() {
        presentSheetViewController()
    }
}
