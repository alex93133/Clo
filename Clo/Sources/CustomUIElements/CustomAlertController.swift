import UIKit

class CustomAlertController: UIAlertController {

    // MARK: - Properties
    private var overlayView: UIView!
    var headLabel: UILabel!
    var imageView: UIImageView!
    var messageLabel: UILabel!
    var stackView: UIStackView!
    var symbol: Symbol? {
        didSet {
            NSLayoutConstraint.activate([view.heightAnchor.constraint(equalToConstant: 220)])
            headLabel.text        = symbol?.description
            imageView.image       = symbol?.image
            messageLabel.isHidden = true
            let cancelAction      = UIAlertAction(title: "Ok", style: .cancel)
            addAction(cancelAction)
        }
    }

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupImageView()
        setupOverlayView()
        setupHeadLabel()
        setupMessageLabel()
        setupStackView()
    }

    // MARK: - View
    private func setupView() {
        view.tintColor                                              = Colors.mintColor
        overrideUserInterfaceStyle                                  = .light
        view.translatesAutoresizingMaskIntoConstraints              = false
        NSLayoutConstraint.activate([view.heightAnchor.constraint(equalToConstant: 320)])
    }

    // MARK: - SymbolImage
    private func setupImageView() {
        imageView             = UIImageView()
        imageView.contentMode = .scaleAspectFill
    }

    // MARK: - OverLayView
    private func setupOverlayView() {
        overlayView                     = UIView()
        overlayView.layer.cornerRadius  = Constants.defaultCornerRadius
        overlayView.backgroundColor     = Colors.whiteColor
        overlayView.layer.shadowColor   = UIColor(red: 0, green: 0, blue: 0, alpha: 0.25).cgColor
        overlayView.layer.shadowOpacity = 1
        overlayView.layer.shadowOffset  = CGSize(width: 0, height: 4)
        overlayView.layer.shadowRadius  = Constants.shadowRadius
        overlayView.addSubview(imageView)
    }

    // MARK: - HeadLabel
    private func setupHeadLabel() {
        headLabel               = UILabel()
        headLabel.font          = .systemFont(ofSize: Constants.Fonts.mediumTextSize, weight: .semibold)
        headLabel.textColor     = Colors.blackTextColor
        headLabel.textAlignment = .center
        headLabel.numberOfLines = 0
    }

    // MARK: - MessageLabel
    private func setupMessageLabel() {
        messageLabel               = UILabel()
        messageLabel.font          = .systemFont(ofSize: Constants.Fonts.smallTextSize, weight: .regular)
        messageLabel.textColor     = Colors.grayTextColor
        messageLabel.textAlignment = .center
        messageLabel.numberOfLines = 0
        messageLabel.sizeToFit()
    }

    // MARK: - StackView
    private func setupStackView() {
        stackView              = UIStackView()
        stackView.alignment    = .center
        stackView.distribution = .equalSpacing
        stackView.spacing      = 8
        stackView.axis         = .vertical

        stackView.addArrangedSubview(overlayView)
        stackView.addArrangedSubview(headLabel)
        stackView.addArrangedSubview(messageLabel)

        setupStackViewConstraints()
        setupOverlayViewConstraints()
        setupHeadLabelConstraints()
        setupMessageLabelConstraints()
    }
}

// MARK: - Constraints
extension CustomAlertController {

    private func setupStackViewConstraints() {
        view.addSubview(stackView)

        stackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                                     stackView.topAnchor.constraint(equalTo: view.topAnchor, constant: 16)])
    }

    private func setupOverlayViewConstraints() {
        overlayView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([overlayView.heightAnchor.constraint(equalToConstant: 70),
                                     overlayView.widthAnchor.constraint(equalToConstant: 70)])
        setupImageViewConstraints()
    }

    private func setupImageViewConstraints() {
        imageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([imageView.leadingAnchor.constraint(equalTo: overlayView.leadingAnchor, constant: 16),
                                     imageView.trailingAnchor.constraint(equalTo: overlayView.trailingAnchor, constant: -16),
                                     imageView.topAnchor.constraint(equalTo: overlayView.topAnchor, constant: 16),
                                     imageView.bottomAnchor.constraint(equalTo: overlayView.bottomAnchor, constant: -16)])
    }

    private func setupHeadLabelConstraints() {
        headLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([headLabel.widthAnchor.constraint(equalToConstant: view.frame.width - 32),
                                     headLabel.heightAnchor.constraint(equalToConstant: 50)])
    }

    private func setupMessageLabelConstraints() {
        messageLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([messageLabel.widthAnchor.constraint(equalToConstant: view.frame.width - 32)])
    }
}
