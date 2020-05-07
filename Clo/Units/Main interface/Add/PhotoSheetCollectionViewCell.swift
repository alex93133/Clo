import UIKit

class PhotoSheetCollectionViewCell: UICollectionViewCell {

    // MARK: - Properties
    var photoImage: UIImageView!
    var takePhotoIcon: UIImageView!

    override init(frame: CGRect) {
        super.init(frame: .zero)
        setupPhotoImage(itemSize: frame.size.height)
    }

    required init?(coder: NSCoder) {
        super.init(frame: .zero)
    }

    // MARK: - PhotoImageView
    private func setupPhotoImage(itemSize: CGFloat) {
        photoImage                    = UIImageView(frame: CGRect(x: 0, y: 0,
                                                                  width: itemSize,
                                                                  height: itemSize))
        photoImage.center             = CGPoint(x: itemSize / 2, y: itemSize / 2)
        photoImage.contentMode        = .scaleAspectFit
        photoImage.clipsToBounds = true

        addSubview(photoImage)
    }

    // MARK: - PhotoImageView
    func setupTakePhotoIcon() {
        let size = frame.height * 2 / 3
        takePhotoIcon                 = UIImageView(frame: CGRect(x: 0, y: 0,
                                                                  width: size,
                                                                  height: size))
        takePhotoIcon.center          = CGPoint(x: frame.size.width / 2, y: frame.size.height / 2)
        takePhotoIcon.contentMode     = .scaleAspectFit
        takePhotoIcon.clipsToBounds   = true
        takePhotoIcon.image           = Images.cameraIcon

        addSubview(takePhotoIcon)
    }

    // MARK: - BlurEffectView
    func setupBlurEffectView() {
        let blurEffect        = UIBlurEffect(style: .prominent)
        let blurEffectView    = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame  = frame
        blurEffectView.center = CGPoint(x: frame.width / 2, y: frame.height / 2)

        addSubview(blurEffectView)
    }
}
