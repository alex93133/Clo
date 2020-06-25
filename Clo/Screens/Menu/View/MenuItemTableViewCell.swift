import UIKit

class MenuItemTableViewCell: UITableViewCell {

    // MARK: - Properties
    private var chevronImageView: UIImageView!

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
        setupChevronImageView()
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
}
