import UIKit

class AddNewItemCollectionViewCell: UICollectionViewCell {
    
    // MARK: - Properties
    var addIconImageView: UIImageView!
    
    override var isHighlighted: Bool {
           didSet {
                   UIView.animate(withDuration: Constants.animationTimeInterval) { [weak self] in
                       guard let self = self else { return }
                       let transform: CGAffineTransform = self.isHighlighted ? .init(scaleX: 0.9, y: 0.9) : .identity
                       self.transform = transform
                   }
           }
       }
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        setupView()
        setupAddIconImageView()
    }
    
    required init?(coder: NSCoder) {
        super.init(frame: .zero)
    }
    
    private func setupView() {
        backgroundColor     = Colors.mintColor
        layer.cornerRadius  = Constants.defaultCornerRadius
        layer.masksToBounds = true
    }
    
    // MARK: - AddIconImageView
    private func setupAddIconImageView() {
        addIconImageView             = UIImageView()
        addIconImageView.contentMode = .scaleAspectFit
        addIconImageView.image       = Images.addNewIcon
        setupAddIconImageViewConstraints()
    }
}

// MARK: - Constraints
extension AddNewItemCollectionViewCell {
    
    private func setupAddIconImageViewConstraints() {
        addSubview(addIconImageView)
        
        addIconImageView.translatesAutoresizingMaskIntoConstraints                                  = false
        addIconImageView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive                  = true
        addIconImageView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive                = true
        addIconImageView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive                  = true
        addIconImageView.heightAnchor.constraint(equalTo: widthAnchor, multiplier: 9 / 16).isActive = true
    }
}