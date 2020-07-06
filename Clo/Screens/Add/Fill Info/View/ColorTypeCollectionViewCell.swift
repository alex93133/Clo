import UIKit

class ColorTypeCollectionViewCell: UICollectionViewCell {

    // MARK: - Properties
    var colorTypeImageView: UIImageView!
    private var shadowView: CloShadowView!

    override init(frame: CGRect) {
        super.init(frame: .zero)
        setupShadowView()
        setupColorTypeImageView()
    }

    required init?(coder _: NSCoder) {
        super.init(frame: .zero)
    }

    private func setupShadowView() {
        shadowView = CloShadowView()
        shadowView.addTo(view: self)
    }

    // MARK: - TypeImageView
    private func setupColorTypeImageView() {
        colorTypeImageView              = UIImageView()
        colorTypeImageView.contentMode  = .scaleAspectFill
        setupColorTypeImageViewConstraints()
    }

    // MARK: - Constraints
    private func setupColorTypeImageViewConstraints() {
        shadowView.containerView.addSubview(colorTypeImageView)
        colorTypeImageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            colorTypeImageView.trailingAnchor.constraint(equalTo: shadowView.trailingAnchor),
            colorTypeImageView.topAnchor.constraint(equalTo: shadowView.topAnchor),
            colorTypeImageView.leadingAnchor.constraint(equalTo: shadowView.leadingAnchor),
            colorTypeImageView.bottomAnchor.constraint(equalTo: shadowView.bottomAnchor)
        ])
    }
}
