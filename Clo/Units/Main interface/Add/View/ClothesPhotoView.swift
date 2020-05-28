import UIKit

class ClothesPhotoView: UIView {

    // MARK: - Properties
    var clothesImageView: UIImageView!

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupClothesImageView()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    // MARK: - ClothesImageView
    private func setupClothesImageView() {
        clothesImageView             = UIImageView()
        clothesImageView.contentMode = .scaleAspectFill
        clothesImageView.layer.masksToBounds = true

        setupClothesImageViewConstraints()
    }
}

// MARK: - Constraints
extension ClothesPhotoView {

    private func setupClothesImageViewConstraints() {
        addSubview(clothesImageView)

        clothesImageView.translatesAutoresizingMaskIntoConstraints                                = false
        clothesImageView.heightAnchor.constraint(equalToConstant: 203).isActive                   = true
        clothesImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 0).isActive   = true
        clothesImageView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 0).isActive = true
        clothesImageView.topAnchor.constraint(equalTo: topAnchor, constant: 0).isActive           = true
    }
}
