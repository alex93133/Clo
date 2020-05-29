import UIKit
import Photos

class PhotoLibraryManager {

    static let shared = PhotoLibraryManager()
    private init() {}

    #warning("убрать синглтон")

    func getPhotos(completion: @escaping (UIImage) -> Void) {
        DispatchQueue.global().async {
            let manager                  = PHImageManager.default()
            let requestOptions           = PHImageRequestOptions()
            requestOptions.isSynchronous = false
            requestOptions.deliveryMode  = .highQualityFormat
            let fetchOptions             = PHFetchOptions()
            fetchOptions.sortDescriptors = [NSSortDescriptor(key: "creationDate", ascending: false)]
            fetchOptions.fetchLimit      = 5

            let results: PHFetchResult = PHAsset.fetchAssets(with: .image, options: fetchOptions)
               guard results.count > 0 else { return }
            for i in 0..<results.count {
                let asset = results.object(at: i)
                let size = CGSize(width: 400, height: 400)
                manager.requestImage(for: asset, targetSize: size, contentMode: .aspectFill, options: requestOptions) { image, _ in
                    if let image = image {
                        completion(image)
                    }
                }
            }
        }
    }
}
