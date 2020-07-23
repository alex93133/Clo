import UIKit

class NewLaundryCollectionViewCell: UICollectionViewCell {

    // MARK: - Properties
    private var shadowView: CloShadowView!
    private var addLabel: UILabel!
    private var backgroundImage: UIImageView!

    override var isHighlighted: Bool {
        didSet {
            animate()
        }
    }

    override init(frame _: CGRect) {
        super.init(frame: .zero)
        setupView()
        setupBackgroundImageView()
        setupAddLabel()
    }

    required init?(coder _: NSCoder) {
        super.init(frame: .zero)
    }

    // MARK: - View
    private func setupView() {
        shadowView = CloShadowView()
        shadowView.addTo(view: self)
    }

    // MARK: - BackgroundImageView
    private func setupBackgroundImageView() {
        backgroundImage             = UIImageView()
        backgroundImage.contentMode = .scaleAspectFill
        backgroundImage.image       = Images.addNewLaundry
        setupBackgroundImageViewConstraints()
    }

    // MARK: - AddLabel
    private func setupAddLabel() {
        addLabel               = UILabel()
        addLabel.textColor     = .white
        addLabel.font          = .systemFont(ofSize: Constants.Fonts.mediumTextSize, weight: .medium)
        addLabel.text          = NSLocalizedString("Collect the wash", comment: "")
        addLabel.textAlignment = .center
        setupAddLabelConstraints()
    }

    // MARK: - Constraints
    private func setupAddLabelConstraints() {
        shadowView.containerView.addSubview(addLabel)
        addLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            addLabel.leadingAnchor.constraint(equalTo: shadowView.leadingAnchor),
            addLabel.topAnchor.constraint(equalTo: shadowView.topAnchor),
            addLabel.trailingAnchor.constraint(equalTo: shadowView.trailingAnchor),
            addLabel.bottomAnchor.constraint(equalTo: shadowView.bottomAnchor)
        ])
    }

    private func setupBackgroundImageViewConstraints() {
        shadowView.containerView.addSubview(backgroundImage)
        backgroundImage.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            backgroundImage.leadingAnchor.constraint(equalTo: shadowView.leadingAnchor),
            backgroundImage.topAnchor.constraint(equalTo: shadowView.topAnchor),
            backgroundImage.trailingAnchor.constraint(equalTo: shadowView.trailingAnchor),
            backgroundImage.bottomAnchor.constraint(equalTo: shadowView.bottomAnchor)
        ])
    }
}
