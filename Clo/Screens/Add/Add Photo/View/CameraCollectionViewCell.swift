import UIKit

class CameraCollectionViewCell: UICollectionViewCell {

    // MARK: - Properties
    var takePhotoIcon: UIImageView!

    override init(frame: CGRect) {
        super.init(frame: .zero)
        setupTakePhotoIcon()
        backgroundColor = .gray
    }

    required init?(coder _: NSCoder) {
        super.init(frame: .zero)
    }

    // MARK: - PhotoImageView
    private func setupTakePhotoIcon() {
        takePhotoIcon                     = UIImageView()
        takePhotoIcon.center              = CGPoint(x: bounds.size.width / 2, y: bounds.size.height / 2)
        takePhotoIcon.contentMode         = .scaleAspectFit
        takePhotoIcon.layer.masksToBounds = true
        takePhotoIcon.image               = Images.cameraIcon
        takePhotoIcon.tintColor           = .white
        setupTakePhotoIconConstraints()
    }

    // MARK: - Constraints
    private func setupTakePhotoIconConstraints() {
        addSubview(takePhotoIcon)
        takePhotoIcon.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            takePhotoIcon.widthAnchor.constraint(equalToConstant: 46),
            takePhotoIcon.heightAnchor.constraint(equalToConstant: 46),
            takePhotoIcon.centerYAnchor.constraint(equalTo: centerYAnchor),
            takePhotoIcon.centerXAnchor.constraint(equalTo: centerXAnchor)
        ])
    }
}
