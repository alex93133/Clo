import UIKit

class CameraCollectionViewCell: UICollectionViewCell {

    // MARK: - Properties
    var photoImage: UIImageView!
    var takePhotoIcon: UIImageView!

    override init(frame: CGRect) {
        super.init(frame: .zero)
        setupTakePhotoIcon(frame: frame)
        backgroundColor = .gray
    }

    required init?(coder: NSCoder) {
        super.init(frame: .zero)
    }

    // MARK: - PhotoImageView
    private func setupTakePhotoIcon(frame: CGRect) {
        let size                          = frame.height * 2 / 3
        takePhotoIcon                     = UIImageView(frame: CGRect(x: 0, y: 0,
                                                                width: size,
                                                                height: size))
        takePhotoIcon.center              = CGPoint(x: frame.size.width / 2, y: frame.size.height / 2)
        takePhotoIcon.contentMode         = .scaleAspectFit
        takePhotoIcon.layer.masksToBounds = true
        takePhotoIcon.image               = Images.cameraIcon

        addSubview(takePhotoIcon)
    }
}
