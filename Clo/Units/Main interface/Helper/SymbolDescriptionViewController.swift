import UIKit

class SymbolDescriptionViewController: UIViewController {

    // MARK: - Properties
    var passedImage: UIImage?
    var passedDescription: String?

    var symbolDescriptionLabel: UILabel!
    var symbolImage: UIImageView!

    // MARK: - Lifecycle
    override func viewDidLoad() {
        setupView()
    }

    // MARK: - Functions
    private func setupView() {
        setupSymbolImage()
        setupSymbolDescriptionLabel()
        view.backgroundColor = .white
    }

    // MARK: - SymbolImage
    private func setupSymbolImage() {
        let size: CGFloat = 100
        symbolImage = UIImageView(frame: CGRect(x: 0, y: 0, width: size, height: size))
        symbolImage.center = CGPoint(x: view.frame.size.width / 2, y: size / 2)
        symbolImage.image = passedImage
        symbolImage.contentMode = .scaleAspectFit

        view.addSubview(symbolImage)
    }

    // MARK: - SymbolDescription
    private func setupSymbolDescriptionLabel() {
        symbolDescriptionLabel               = UILabel()
        symbolDescriptionLabel.font          = .systemFont(ofSize: Sizes.mediumTextSize, weight: .regular)
        symbolDescriptionLabel.textColor     = Colors.textColor
        symbolDescriptionLabel.textAlignment = .center
        symbolDescriptionLabel.numberOfLines = 0
        symbolDescriptionLabel.text = passedDescription

        setupSymbolDescriptionLabelConstraints()
    }
}

// MARK: - Constraints
extension SymbolDescriptionViewController {

    func setupSymbolDescriptionLabelConstraints() {
        view.addSubview(symbolDescriptionLabel)

        symbolDescriptionLabel.translatesAutoresizingMaskIntoConstraints                                       = false
        symbolDescriptionLabel.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive                    = true
        symbolDescriptionLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16).isActive    = true
        symbolDescriptionLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16).isActive = true
        symbolDescriptionLabel.topAnchor.constraint(equalTo: symbolImage.bottomAnchor, constant: 16).isActive  = true
    }
}
