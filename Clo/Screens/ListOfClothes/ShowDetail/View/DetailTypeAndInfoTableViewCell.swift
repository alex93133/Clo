import UIKit

class DetailTypeAndInfoTableViewCell: UITableViewCell {
    
    // MARK: - Properties
    private var stackView: UIStackView!
    var typeLabel: UILabel!
    var infoLabel: UILabel!

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupTypeLabel()
        setupInfoLabel()
        setupStackView()
        backgroundColor = Colors.mainBG
        selectionStyle  = .none
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    // MARK: - TypeLabel
    private func setupTypeLabel() {
        typeLabel           = UILabel(frame: CGRect(x: 0, y: 0, width: 312, height: 194))
        typeLabel.textColor = Colors.accent
        typeLabel.font      = .systemFont(ofSize: Constants.Fonts.clothesTypeTextSize, weight: .semibold)
    }

    // MARK: - InfoLabel
    private func setupInfoLabel() {
        infoLabel           = UILabel(frame: CGRect(x: 0, y: 0, width: 312, height: 194))
        infoLabel.textColor = Colors.textGray
        infoLabel.font      = .systemFont(ofSize: Constants.Fonts.mediumTextSize, weight: .regular)
    }

    // MARK: - StackView
    private func setupStackView() {
        stackView              = UIStackView()
        stackView.alignment    = .leading
        stackView.distribution = .equalSpacing
        stackView.spacing      = 8
        stackView.axis         = .vertical

        stackView.addArrangedSubview(typeLabel)
        stackView.addArrangedSubview(infoLabel)
        setupStackViewConstraints()
    }
}

// MARK: - Constraints
extension DetailTypeAndInfoTableViewCell {
    
    private func setupStackViewConstraints() {
        addSubview(stackView)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([stackView.topAnchor.constraint(equalTo: topAnchor, constant: 16),
                                     stackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -16),
                                     stackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
                                     stackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16)])
    }
}
