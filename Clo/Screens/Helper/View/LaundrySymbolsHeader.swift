import UIKit

class LaundrySymbolsHeader: UICollectionReusableView {

    // MARK: - Properties
    var headerLabel: UILabel!

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupHeaderLabel()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    // MARK: - HeaderLabel
    private func setupHeaderLabel() {
        headerLabel = UILabel()
        headerLabel.textColor = Colors.blackTextColor
        headerLabel.font = .systemFont(ofSize: Constants.Fonts.mediumTextSize, weight: .semibold)
        headerLabel.sizeToFit()
        setupHeaderLabelConstraints()
    }
}

// MARK: - Constraints
extension LaundrySymbolsHeader {

    private func setupHeaderLabelConstraints() {
        addSubview(headerLabel)

        headerLabel.translatesAutoresizingMaskIntoConstraints                           = false
        headerLabel.heightAnchor.constraint(equalToConstant: frame.height).isActive     = true
        headerLabel.centerYAnchor.constraint(equalTo: centerYAnchor).isActive           = true
        headerLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: 16).isActive   = true
        headerLabel.rightAnchor.constraint(equalTo: rightAnchor, constant: 16).isActive = true
    }
}
