import UIKit
import Photos

class GalleryViewController: UIViewController {
    
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
                self.view().collectionView.reloadData()
            }
        }
    }
    
    private func showAddClothesViewController(image: UIImage) {
        let addClothesViewController = AddClothesViewController(image: image)
        let navigationController = UINavigationController(rootViewController: addClothesViewController)
        navigationController.modalPresentationStyle = .fullScreen
        present(navigationController, animated: true)
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
            showAddClothesViewController(image: capturedImage)
        }
    }
}

extension GalleryViewController: UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    func setupImagePicker() {
        imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = .camera
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
        imagePicker.dismiss(animated: true)
        guard let capturedImage = info[.originalImage] as? UIImage else { return }
        showAddClothesViewController(image: capturedImage)
    }
}