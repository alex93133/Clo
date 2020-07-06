import UIKit

class MenuItemTableViewCell: UITableViewCell {

    // MARK: - Properties
    var chevronImageView: UIImageView!
    var activityIndicator: UIActivityIndicatorView!
    var isProcessing: Bool {
        get {
            return false
        }
        set {
            UIView.animate(withDuration: Constants.animationTimeInterval) { [weak self] in
                guard let self = self else { return }
                self.chevronImageView.isHidden = newValue
                if newValue {
                    self.activityIndicator.startAnimating()
                } else {
                    self.activityIndicator.stopAnimating()
                }
            }
        }
    }

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
        setupChevronImageView()
        setupActivityIndicator()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    private func setupView() {
        backgroundColor = Colors.mainBG
        selectionStyle  = .none
        textLabel?.font = .systemFont(ofSize: Constants.Fonts.mediumTextSize, weight: .regular)
    }

    // MARK: - ChevronImageView
    private func setupChevronImageView() {
        chevronImageView             = UIImageView()
        chevronImageView.contentMode = .scaleAspectFill
        chevronImageView.image       = Images.Menu.chevron
        chevronImageView.tintColor   = Colors.textGray
        setupChevronImageViewConstraints()
    }

    private func setupActivityIndicator() {
        activityIndicator = UIActivityIndicatorView()
        activityIndicator.hidesWhenStopped = true
        activityIndicator.color            = Colors.mint
        setupActivityIndicatorConstraints()
    }

    // MARK: - Constraints
    private func setupChevronImageViewConstraints() {
        addSubview(chevronImageView)
        chevronImageView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            chevronImageView.heightAnchor.constraint(equalToConstant: 7),
            chevronImageView.widthAnchor.constraint(equalToConstant: 14),
            chevronImageView.centerYAnchor.constraint(equalTo: centerYAnchor),
            chevronImageView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20)
        ])
    }

    private func setupActivityIndicatorConstraints() {
        addSubview(activityIndicator)
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            activityIndicator.centerYAnchor.constraint(equalTo: chevronImageView.centerYAnchor),
            activityIndicator.centerXAnchor.constraint(equalTo: chevronImageView.centerXAnchor)
        ])
    }
}
