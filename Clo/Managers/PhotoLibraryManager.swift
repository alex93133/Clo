import UIKit
import Photos

class PhotoLibraryManager {

    var runRequesting: Bool = true

    func getPhotos(completion: @escaping (UIImage) -> Void) {
        DispatchQueue.global(qos: .background).async { [unowned self] in
            let manager                  = PHImageManager.default()
            let requestOptions           = PHImageRequestOptions()
            requestOptions.isSynchronous = true
            requestOptions.deliveryMode  = .highQualityFormat
            let fetchOptions             = PHFetchOptions()
            fetchOptions.sortDescriptors = [NSSortDescriptor(key: "creationDate", ascending: false)]

            let results: PHFetchResult = PHAsset.fetchAssets(with: .image, options: fetchOptions)
            guard results.count > 0 else { return }
            for i in 0..<results.count {
                let asset = results.object(at: i)
                let size = CGSize(width: 1000, height: 1000)
                if self.runRequesting {
                    manager.requestImage(for: asset, targetSize: size, contentMode: .aspectFill, options: requestOptions) { image, _ in
                        if let image = image {
                            completion(image)
                        }
                    }
                } else {
                    break
                }
            }

        }
    }
}
