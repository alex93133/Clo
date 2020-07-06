import UIKit

class LaundrySymbolsCollectionViewCell: UICollectionViewCell {

    // MARK: - Properties
    var laundryImage: UIImageView!
    private var shadowView: CloShadowView!

    override var isHighlighted: Bool {
        didSet {
            animate()
        }
    }

    override init(frame: CGRect) {
        super.init(frame: .zero)
        setupContainerView()
        setupLaundryImage()
    }

    required init?(coder _: NSCoder) {
        super.init(frame: .zero)
    }

    // MARK: - View
    private func setupContainerView() {
        shadowView = CloShadowView()
        shadowView.addTo(view: self)
    }

    // MARK: - LaundryImage
    private func setupLaundryImage() {
        laundryImage             = UIImageView()
        laundryImage.contentMode = .scaleAspectFit
        laundryImage.tintColor   = Colors.accent
        setupLaundryImageViewConstraints()
    }

    // MARK: - Constraints
    private func setupLaundryImageViewConstraints() {
        shadowView.containerView.addSubview(laundryImage)
        laundryImage.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            laundryImage.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.5),
            laundryImage.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.5),
            laundryImage.centerYAnchor.constraint(equalTo: centerYAnchor),
            laundryImage.centerXAnchor.constraint(equalTo: centerXAnchor)
        ])
    }
}
