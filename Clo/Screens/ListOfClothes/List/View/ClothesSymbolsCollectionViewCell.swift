import UIKit

class ClothesSymbolsCollectionViewCell: UICollectionViewCell {
    
    // MARK: - Properties
    var laundryImageView: UIImageView!

    override init(frame _: CGRect) {
        super.init(frame: .zero)
        setupView()
        setupLaundryImageView()
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

    // MARK: - LaundryImageView
    private func setupLaundryImageView() {
        laundryImageView             = UIImageView()
        laundryImageView.contentMode = .scaleAspectFill
        laundryImageView.tintColor   = Colors.accent
        setupLaundryImageViewConstraints()
    }
}

// MARK: - Constraints
extension ClothesSymbolsCollectionViewCell {
  
    private func setupLaundryImageViewConstraints() {
        addSubview(laundryImageView)
        laundryImageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([laundryImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 6),
                                     laundryImageView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -6),
                                     laundryImageView.topAnchor.constraint(equalTo: topAnchor, constant: 6),
                                     laundryImageView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -6)])
    }
}
