import UIKit

class ClothesSymbolsCollectionViewCell: UICollectionViewCell {

    // MARK: - Properties
    var washingImageView: UIImageView!

    override init(frame _: CGRect) {
        super.init(frame: .zero)
        setupView()
        setupWashingImageView()
    }

    required init?(coder _: NSCoder) {
        super.init(frame: .zero)
    }

    // MARK: - View
    private func setupView() {
        layer.cornerRadius  = Constants.defaultCornerRadius
        layer.borderColor   = UIColor.clear.cgColor
        layer.masksToBounds = true
        backgroundColor     = Colors.additionalBG
    }

    // MARK: - WashingImageView
    private func setupWashingImageView() {
        washingImageView             = UIImageView()
        washingImageView.contentMode = .scaleAspectFill
        washingImageView.tintColor   = Colors.accent
        setupWashingImageViewConstraints()
    }

    // MARK: - Constraints
    private func setupWashingImageViewConstraints() {
        addSubview(washingImageView)
        washingImageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            washingImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 6),
            washingImageView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -6),
            washingImageView.topAnchor.constraint(equalTo: topAnchor, constant: 6),
            washingImageView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -6)
        ])
    }
}
