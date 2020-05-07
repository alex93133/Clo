import UIKit
import Photos
import AVFoundation

class PhotoSheetViewController: UIViewController {

    // MARK: - Properties
    let customView = PhotoSheetView(frame: UIScreen.main.bounds)
    var imagePicker: UIImagePickerController!
    var allPhotos = PHFetchResult<PHAsset>() {
        didSet {
            DispatchQueue.main.async {
                self.view().collectionView.reloadData()
            }
        }
    }

    var videoDataOutput: AVCaptureVideoDataOutput!
    var videoDataOutputQueue: DispatchQueue!
    var previewLayer: AVCaptureVideoPreviewLayer!
    var captureDevice: AVCaptureDevice!
    let session = AVCaptureSession()

    // MARK: - Lifecycle
    override func loadView() {
        setupView()
    }

    override func viewDidDisappear(_ animated: Bool) {
        session.stopRunning()
    }

    // MARK: - Functions
    private func view() -> PhotoSheetView {
        return view as! PhotoSheetView
    }

    private func setupView() {
        view  =  customView
        view().collectionView.dataSource = self
        view().collectionView.delegate = self
        getPhotos()
    }

    private func getPhotos() {
        PHPhotoLibrary.requestAuthorization { [unowned self] status in
            switch status {
            case .authorized:
                let fetchOptions = PHFetchOptions()
                fetchOptions.sortDescriptors = [NSSortDescriptor(key: "creationDate", ascending: false)]
                self.allPhotos = PHAsset.fetchAssets(with: .image, options: fetchOptions)
            case .denied, .restricted:
                print("Not allowed")
            case .notDetermined:
                print("Not determined yet")
            @unknown default:
                return
            }
        }
    }
}

// MARK: - UICollectionViewDelegate
extension PhotoSheetViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        allPhotos.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Constants.photoCellIdentifier, for: indexPath) as! PhotoSheetCollectionViewCell

        switch indexPath.item {
        case 0:
            cell.setupBlurEffectView()
            cell.setupTakePhotoIcon()
            setupAVCapture(targetLayer: cell.photoImage.layer)
        default:
            let asset = allPhotos.object(at: indexPath.item - 1)
            cell.photoImage.fetchImage(asset: asset, contentMode: .aspectFill, targetSize: CGSize(width: 300, height: 300))
        }

        return cell
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        switch indexPath.item {
        case 0:
            setupImagePicker()
            present(imagePicker, animated: true)
        default: break
        }
    }
}

// MARK: - SheetViewControllerDelegate
extension PhotoSheetViewController: UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    func setupImagePicker() {
        imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = .camera
    }

    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
        imagePicker.dismiss(animated: true, completion: nil)
        //        let image = info[.originalImage] as? UIImage
    }
}

// MARK: - AVCaptureDelegate
extension PhotoSheetViewController: AVCaptureVideoDataOutputSampleBufferDelegate {

    func setupAVCapture(targetLayer: CALayer) {
        session.sessionPreset = AVCaptureSession.Preset.vga640x480
        guard let device = AVCaptureDevice
            .default(AVCaptureDevice.DeviceType.builtInWideAngleCamera,
                     for: .video,
                     position: AVCaptureDevice.Position.back) else {
                        return
        }
        captureDevice = device
        beginSession(targetLayer: targetLayer)
    }

    func beginSession(targetLayer: CALayer) {
        var deviceInput: AVCaptureDeviceInput!

        do {
            deviceInput = try AVCaptureDeviceInput(device: captureDevice)
            guard deviceInput != nil else { return }

            if self.session.canAddInput(deviceInput) {
                session.addInput(deviceInput)
            }

            videoDataOutput                               = AVCaptureVideoDataOutput()
            videoDataOutput.alwaysDiscardsLateVideoFrames = true
            videoDataOutputQueue                          = DispatchQueue(label: "VideoDataOutputQueue")
            videoDataOutput.setSampleBufferDelegate(self, queue: videoDataOutputQueue)

            if session.canAddOutput(videoDataOutput) {
                session.addOutput(videoDataOutput)
            }

            videoDataOutput.connection(with: .video)?.isEnabled = true

            previewLayer              = AVCaptureVideoPreviewLayer(session: session)
            previewLayer.videoGravity = AVLayerVideoGravity.resizeAspect

            let aspectRatio: CGFloat  = 4 / 3
            previewLayer.frame        = CGRect(x: 0, y: 0,
                                               width: targetLayer.frame.width,
                                               height: targetLayer.frame.height * aspectRatio)
            targetLayer.masksToBounds = true
            targetLayer.addSublayer(previewLayer)

            session.startRunning()
        } catch let error as NSError {
            deviceInput = nil
            print("error: \(error.localizedDescription)")
        }
    }
}
