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

    enum AccessResult {
        case allow
        case warning
        case error
    }

    enum RequestResult {
        case accessed
        case denied
    }

    // MARK: - Functions
    static func checkAccessStatus(handler: @escaping (AccessResult) -> Void) {
        let statusOfLibrary = PHPhotoLibrary.authorizationStatus()
        let statusOfCamera  = AVCaptureDevice.authorizationStatus(for: AVMediaType.video)

        if statusOfLibrary == .notDetermined || statusOfCamera == .notDetermined {
            handler(.warning)
        }

        if statusOfLibrary == .denied || statusOfCamera == .denied {
            handler(.error)
        }

        if statusOfLibrary == .authorized, statusOfCamera == .authorized {
            handler(.allow)
        }
    }

    static func getAccess(handler: @escaping (RequestResult) -> Void) {
        AVCaptureDevice.requestAccess(for: .video) { successOfCameraRequest in
            PHPhotoLibrary.requestAuthorization { resultOfLibrary in
                if resultOfLibrary == .authorized && successOfCameraRequest {
                    DispatchQueue.main.async {
                        handler(.accessed)
                    }
                } else {
                    DispatchQueue.main.async {
                        handler(.denied)
                    }
                }
            }
        }
    }

    private func setupSession() {
        requestOptions.isSynchronous = true
        requestOptions.deliveryMode  = .opportunistic
        fetchOptions.sortDescriptors = [NSSortDescriptor(key: "creationDate", ascending: false)]
    }

    func getAllPhotos(completion: @escaping (UIImage) -> Void) {
        DispatchQueue.global(qos: .background).async {
            let results: PHFetchResult = PHAsset.fetchAssets(with: .image, options: self.fetchOptions)
            guard results.count > 0 else { return }
            for index in 0 ..< results.count {
                let asset = results.object(at: index)
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
        let asset   = results.object(at: index)
        let manager = PHImageManager.default()
        let size    = CGSize(width: asset.pixelWidth, height: asset.pixelHeight)

        manager.requestImage(for: asset,
                             targetSize: size,
                             contentMode: .aspectFit,
                             options: requestOptions) { image, _ in
                                guard let image = image else { return }
                                completion(image)
        }
    }
}
