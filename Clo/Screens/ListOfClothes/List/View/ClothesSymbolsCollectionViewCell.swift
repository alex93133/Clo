import UIKit

class ClothesSymbolsCollectionViewCell: UICollectionViewCell {
    
    // MARK: - Properties
    var laundryImageView: UIImageView!
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        setupView()
        setupLaundryImageView()
    }
    
    required init?(coder: NSCoder) {
        super.init(frame: .zero)
    }
    
    // MARK: - View
    private func setupView() {
        layer.cornerRadius  = Constants.defaultCornerRadius
        layer.borderColor   = UIColor.clear.cgColor
        layer.masksToBounds = true
        backgroundColor     = Colors.lightGrayBGColor
    }
    
    // MARK: - LaundryImageView
    private func setupLaundryImageView() {
        laundryImageView             = UIImageView()
        laundryImageView.contentMode = .scaleAspectFit
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
