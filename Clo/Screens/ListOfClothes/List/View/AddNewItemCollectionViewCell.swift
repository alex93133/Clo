import UIKit

class AddNewItemCollectionViewCell: UICollectionViewCell {

    // MARK: - Properties
    var addIconImageView: UIImageView!
    override var isHighlighted: Bool {
        didSet {
            animate()
        }
    }

    override init(frame _: CGRect) {
        super.init(frame: .zero)
        setupView()
        setupAddIconImageView()
    }

    required init?(coder _: NSCoder) {
        super.init(frame: .zero)
    }

    private func setupView() {
        backgroundColor     = Colors.mint
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

    // MARK: - Constraints
    private func setupAddIconImageViewConstraints() {
        addSubview(addIconImageView)
        addIconImageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            addIconImageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            addIconImageView.trailingAnchor.constraint(equalTo: trailingAnchor),
            addIconImageView.centerYAnchor.constraint(equalTo: centerYAnchor),
            addIconImageView.heightAnchor.constraint(equalTo: widthAnchor, multiplier: 9 / 16)
        ])
    }
}
