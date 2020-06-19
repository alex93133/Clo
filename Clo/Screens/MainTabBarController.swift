import UIKit
import Photos
import AVFoundation

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
        tabBar.barTintColor      = Colors.whiteColor
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

        let clothesListViewController = ClothesListViewController()
        clothesListViewController.delegate = self
        let item2 = UINavigationController(rootViewController: clothesListViewController)
        let icon2 = UITabBarItem(title: "", image: Images.clothesIcon, tag: 2)
        item2.tabBarItem = icon2

        let item3 = UIViewController()
        let icon3 = UITabBarItem(title: "", image: Images.addIcon, tag: 3)
        item3.tabBarItem = icon3

        let controllers = [item1, item2, item3]
        viewControllers = controllers
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
            self.presentAddClothesViewController(image: image)
            self.imageToPass = nil
        }
        present(gallerySheet.sheet, animated: false)
    }

    private func presentAddClothesViewController(image: UIImage) {
        let addClothesViewController                = AddEditClothesViewController(image: image)
        let navigationController                    = UINavigationController(rootViewController: addClothesViewController)
        navigationController.modalPresentationStyle = .fullScreen
        present(navigationController, animated: true)
    }

    private func presentViewWithWarning() {
        let alert = CustomAlertController(title: nil, message: nil, preferredStyle: .actionSheet)

        let cancelAction  = UIAlertAction(title: "Maybe later", style: .cancel)
        alert.addAction(cancelAction)
        let getAccessAction = UIAlertAction(title: "Get access", style: .default) { [weak self] _ in
            guard let self = self else { return }
            self.getAccess()
        }
        alert.addAction(getAccessAction)

        present(alert, animated: true)

        alert.imageView.image   = Images.cameraIcon
        alert.headLabel.text    = "Please note"
        alert.messageLabel.text = "For the full application, you will need a smartphone camera. Please allow access"
    }

    private func getAccess() {
        AVCaptureDevice.requestAccess(for: .video) { successOfCameraRequest in
            PHPhotoLibrary.requestAuthorization { [weak self]  resultOfLibrary in
                guard let self = self else { return }
                if resultOfLibrary == .authorized && successOfCameraRequest {
                    DispatchQueue.main.async {
                        self.presentSheetViewController()
                    }
                }
            }
        }
    }

    private func presentViewWithError() {
        let alert = CustomAlertController(title: nil, message: nil, preferredStyle: .actionSheet)

        let cancelAction  = UIAlertAction(title: "Maybe later", style: .cancel)
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
        if tabBarController.customizableViewControllers?.firstIndex(of: viewController) == 2 {

            let statusOfLibrary = PHPhotoLibrary.authorizationStatus()
            let statusOfCamera = AVCaptureDevice.authorizationStatus(for: AVMediaType.video)

            if statusOfLibrary == .notDetermined || statusOfCamera == .notDetermined {
                presentViewWithWarning()
                return false
            }

            if statusOfLibrary == .denied || statusOfCamera == .denied {
                presentViewWithError()
                return false
            }

            if statusOfLibrary == .authorized && statusOfCamera == .authorized {
                presentSheetViewController()
            }

            return false
        } else {
            return true
        }
    }
}

extension MainTabBarController: ClothesListViewControllerDelegate {

    func presentPhotoSheet() {
        presentSheetViewController()
    }
}
