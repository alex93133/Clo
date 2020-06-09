import UIKit

class ClothesSymbolsCollectionViewCell: UICollectionViewCell {
    
    // MARK: - Properties
    var laundryImageView: UIImageView!
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        setupView()
        setupLaundryImageView(itemSize: frame.width)
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
    private func setupLaundryImageView(itemSize: CGFloat) {
        laundryImageView             = UIImageView()
        laundryImageView.contentMode = .scaleAspectFit
        setupLaundryImageViewConstraints()
    }
}

// MARK: - Constraints
extension ClothesSymbolsCollectionViewCell {
    
    private func setupLaundryImageViewConstraints() {
        addSubview(laundryImageView)
        
        laundryImageView.translatesAutoresizingMaskIntoConstraints                                 = false
        laundryImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 6).isActive    = true
        laundryImageView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -6).isActive = true
        laundryImageView.topAnchor.constraint(equalTo: topAnchor, constant: 6).isActive            = true
        laundryImageView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -6).isActive     = true
    }
}
