import Photos
import UIKit

class PhotoLibraryManager {

    // MARK: - Properties
    private let manager = PHImageManager.default()
    private var requestOptions = PHImageRequestOptions()
    private let fetchOptions = PHFetchOptions()

    init() {
        setupSession()
    }

    // MARK: - Functions
    private func setupSession() {
        requestOptions.isSynchronous = true
        requestOptions.deliveryMode  = .opportunistic
        fetchOptions.sortDescriptors = [NSSortDescriptor(key: "creationDate", ascending: false)]
    }

    func getAllPhotos(completion: @escaping (UIImage) -> Void) {
        DispatchQueue.global(qos: .background).async {
            let results: PHFetchResult = PHAsset.fetchAssets(with: .image, options: self.fetchOptions)
            guard results.count > 0 else { return }
            for i in 0..<results.count {
                let asset = results.object(at: i)
                let size = CGSize(width: 300, height: 300)
                self.manager.requestImage(for: asset, targetSize: size, contentMode: .aspectFill, options: self.requestOptions) { image, _ in
                    if let image = image {
                        completion(image)
                    }
                }
            }
        }
    }

    func getOriginalPhotoFromLibrary(index: Int, completion: @escaping (UIImage) -> Void) {
        let results = PHAsset.fetchAssets(with: PHAssetMediaType.image, options: fetchOptions)
        guard results.count > 0 else { return }
        let asset = results.object(at: index)
        let manager = PHImageManager.default()
        let size = CGSize(width: asset.pixelWidth, height: asset.pixelHeight)

        manager.requestImage(for: asset,
                             targetSize: size,
                             contentMode: .aspectFit,
                             options: requestOptions,
                             resultHandler: { image, _ in
                                guard let image = image else { return }
                                completion(image)
        })
    }
}
