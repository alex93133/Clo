import UIKit

class GalleryCollectionViewCell: UICollectionViewCell {

    // MARK: - Properties
    var photoImage: UIImageView!

    override init(frame: CGRect) {
        super.init(frame: .zero)
        setupPhotoImage(frame: frame)
    }

    required init?(coder: NSCoder) {
        super.init(frame: .zero)
    }

    // MARK: - PhotoImageView
    private func setupPhotoImage(frame: CGRect) {
        let itemSize                   = frame.size.height
        photoImage                     = UIImageView(frame: CGRect(x: 0, y: 0,
                                                             width: itemSize,
                                                             height: itemSize))
        photoImage.center              = CGPoint(x: itemSize / 2, y: itemSize / 2)
        photoImage.contentMode         = .scaleAspectFill
        photoImage.layer.masksToBounds = true

        addSubview(photoImage)
    }
}
