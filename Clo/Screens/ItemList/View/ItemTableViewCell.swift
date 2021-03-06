import UIKit

class ItemTableViewCell: UITableViewCell {

    // MARK: - Properties
    var checkBox: UIImageView!

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupLabel()
        setupCheckBox()
        backgroundColor = Colors.mainBG
        selectionStyle  = .none
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        if selected {
            UIView.animate(withDuration: Constants.animationTimeInterval) { [weak self] in
                guard let self = self else { return }
                self.checkBox.alpha = 1
            }
        } else {
            checkBox.alpha = 0
        }
    }

    // MARK: - Label
    private func setupLabel() {
        textLabel?.textColor = Colors.accent
        textLabel?.font      = .systemFont(ofSize: Constants.Fonts.mediumTextSize, weight: .regular)
    }

    // MARK: - CheckBox
    private func setupCheckBox() {
        checkBox             = UIImageView()
        checkBox.contentMode = .scaleAspectFill
        checkBox.image       = Images.checkBox
        checkBox.alpha       = 0
        setupCheckBoxConstraints()
    }

    // MARK: - Constraints
    private func setupCheckBoxConstraints() {
        addSubview(checkBox)
        checkBox.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            checkBox.widthAnchor.constraint(equalToConstant: 28),
            checkBox.heightAnchor.constraint(equalToConstant: 28),
            checkBox.centerYAnchor.constraint(equalTo: centerYAnchor),
            checkBox.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -21)
        ])
    }
}
