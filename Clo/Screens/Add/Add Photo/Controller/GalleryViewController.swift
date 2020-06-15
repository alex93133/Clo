import UIKit
import CropViewController

protocol GalleryViewControllerDelegate: class {
    func updateImage(with image: UIImage)
}

class GalleryViewController: UIViewController, CropViewControllerDelegate {

    // MARK: - Properties
    private let customView = GalleryView(frame: UIScreen.main.bounds)
    private var imagePicker: UIImagePickerController!
    private var allPhotos = [UIImage]()
    private var photoLibraryManager = PhotoLibraryManager()
    var itemHasImage: Bool = false
    weak var delegate: GalleryViewControllerDelegate!
    var cropViewControllerHandler: ((UIImage) -> Void)?

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
        photoLibraryManager.getAllPhotos { [weak self] image in
            guard let self = self else { return }
            self.allPhotos.append(image)
            let indexPath = IndexPath(item: self.allPhotos.count - 1, section: 0)
            DispatchQueue.main.async {
                self.view().collectionView.insertItems(at: [indexPath])
            }
        }
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

        let scaledImage = image.resizeImage(targetSize: CGSize(width: 1100, height: 1100 * 9 / 16))
        if itemHasImage {
            delegate.updateImage(with: scaledImage)
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + Constants.animationTimeInterval) { [weak self] in
            guard let self = self else { return }
            self.sheetViewController?.closeSheet()
            self.cropViewControllerHandler?(scaledImage)
        }
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
            photoLibraryManager.getOriginalPhotoFromLibrary(index: indexPath.item - 1) { [weak self] image in
                guard let self = self else { return }
                self.presentPhotoEditor(image: image)
            }
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
