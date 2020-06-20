import UIKit

class DetailSymbolsTableViewCell: UITableViewCell {
    
    // MARK: - Properties
    var symbolImageView: UIImageView!
    var descriptionLabel: UILabel!
    private var view: UIView!
    private var customSeparator: UIView!

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
        setupSymbolImageView()
        setupDescriptionLabel()
        setupCustomSeparator()
        backgroundColor = Colors.mainBG
        selectionStyle  = .none
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    // MARK: - View
    private func setupView() {
        view                     = UIView()
        view.backgroundColor     = Colors.mainBG
        view.layer.cornerRadius  = Constants.defaultCornerRadius
        view.layer.masksToBounds = true
        setupViewConstraints()
    }

    private func setupCustomSeparator() {
        customSeparator                 = UIView()
        customSeparator.backgroundColor = Colors.border
        setupCustomSeparatorConstraints()
    }

    // MARK: - SymbolImageView
    private func setupSymbolImageView() {
        symbolImageView             = UIImageView()
        symbolImageView.contentMode = .scaleAspectFit
        symbolImageView.tintColor   = Colors.accent
        setupSymbolImageViewConstraints()
    }

    private func setupDescriptionLabel() {
        descriptionLabel               = UILabel()
        descriptionLabel.numberOfLines = 0
        descriptionLabel.textColor     = Colors.textGray
        descriptionLabel.font          = .systemFont(ofSize: Constants.Fonts.smallTextSize, weight: .regular)
        setupDescriptionLabelConstraints()
    }
}

// MARK: - Constraints
extension DetailSymbolsTableViewCell {
   
    private func setupCustomSeparatorConstraints() {
        addSubview(customSeparator)
        customSeparator.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([customSeparator.heightAnchor.constraint(equalToConstant: 0.5),
                                     customSeparator.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 12),
                                     customSeparator.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -12),
                                     customSeparator.bottomAnchor.constraint(equalTo: bottomAnchor)])
    }

    private func setupSymbolImageViewConstraints() {
        view.addSubview(symbolImageView)
        symbolImageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([symbolImageView.widthAnchor.constraint(equalToConstant: 30),
                                     symbolImageView.heightAnchor.constraint(equalToConstant: 30),
                                     symbolImageView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
                                     symbolImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor)])
    }

    private func setupViewConstraints() {
        addSubview(view)
        view.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([view.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
                                     view.topAnchor.constraint(equalTo: topAnchor, constant: 8),
                                     view.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -8),
                                     view.heightAnchor.constraint(equalToConstant: 42),
                                     view.widthAnchor.constraint(equalToConstant: 42)])
    }

    private func setupDescriptionLabelConstraints() {
        addSubview(descriptionLabel)
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([descriptionLabel.heightAnchor.constraint(equalToConstant: 42),
                                     descriptionLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 74),
                                     descriptionLabel.topAnchor.constraint(equalTo: topAnchor, constant: 8),
                                     descriptionLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -8),
                                     descriptionLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -37)])
    }
}
