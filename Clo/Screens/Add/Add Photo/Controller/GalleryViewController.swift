import UIKit
import Photos
import CropViewController

class GalleryViewController: UIViewController, CropViewControllerDelegate {

    // MARK: - Properties
    private let customView = GalleryView(frame: UIScreen.main.bounds)
    private var imagePicker: UIImagePickerController!
    private var allPhotos = [UIImage]()
    var photoLibraryManager: PhotoLibraryManager!

    // MARK: - Lifecycle
    override func viewDidLoad() {
        setupView()
        setupImagePicker()
        getPhotos()
    }

    // MARK: - Functions
    private func view() -> GalleryView {
        return view as! GalleryView
    }

    private func setupView() {
        view  =  customView
        view().collectionView.dataSource = self
        view().collectionView.delegate = self
    }

    private func getPhotos() {
        photoLibraryManager = PhotoLibraryManager()
        photoLibraryManager.getPhotos { [unowned self] image in
            DispatchQueue.main.async {
                self.allPhotos.append(image)
                let indexPath = IndexPath(item: self.allPhotos.count - 1, section: 0)
                self.view().collectionView.insertItems(at: [indexPath])
            }
        }
    }

    private func presentAddClothesViewController(image: UIImage) {
        let addClothesViewController                = AddEditClothesViewController(image: image)
        let navigationController                    = UINavigationController(rootViewController: addClothesViewController)
        navigationController.modalPresentationStyle = .fullScreen
        present(navigationController, animated: true)
    }

    private func presentPhotoEditor(image: UIImage) {
        let cropViewController                           = CropViewController(croppingStyle: .default, image: image)
        cropViewController.delegate                      = self
        cropViewController.aspectRatioPickerButtonHidden = true
        cropViewController.aspectRatioLockEnabled        = true
        cropViewController.resetAspectRatioEnabled       = false
        cropViewController.aspectRatioPreset             = .preset16x9
        present(cropViewController, animated: true)
    }

    func cropViewController(_ cropViewController: CropViewController, didCropToImage image: UIImage, withRect cropRect: CGRect, angle: Int) {
        cropViewController.dismiss(animated: true)
        presentAddClothesViewController(image: image)
    }
}

// MARK: - Delegates
extension GalleryViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        allPhotos.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let photoCell = collectionView.dequeueReusableCell(withReuseIdentifier: Identifiers.photoCellIdentifier, for: indexPath) as? GalleryCollectionViewCell
            else { return UICollectionViewCell() }

        guard let cameraCell = collectionView.dequeueReusableCell(withReuseIdentifier: Identifiers.cameraInputCellIdentifier, for: indexPath) as? CameraCollectionViewCell
            else { return UICollectionViewCell() }
        switch indexPath.item {
        case 0:
            return cameraCell
        default:
            photoCell.photoImage.image = allPhotos[indexPath.item - 1]
            return photoCell
        }
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        switch indexPath.item {
        case 0:
            present(imagePicker, animated: true)
        default:
            let capturedImage = allPhotos[indexPath.item - 1]
            photoLibraryManager.runRequesting = false
            presentPhotoEditor(image: capturedImage)
        }
    }
}

extension GalleryViewController: UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    func setupImagePicker() {
        imagePicker               = UIImagePickerController()
        imagePicker.delegate      = self
        imagePicker.sourceType    = .camera
    }

    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true)
    }

    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
        imagePicker.dismiss(animated: true)
        guard let capturedImage = info[.originalImage] as? UIImage else { return }
        presentPhotoEditor(image: capturedImage)
    }
}
