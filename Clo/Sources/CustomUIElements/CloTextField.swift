import UIKit

class CloTextField: UITextField {

    override init(frame _: CGRect) {
        super.init(frame: .zero)
        setup()
    }

    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    convenience init(placeholder: String, addTo view: UIView) {
        self.init(frame: .zero)
        let attributes = [
            NSAttributedString.Key.foregroundColor: Colors.textGray,
            NSAttributedString.Key.font: UIFont.systemFont(ofSize: Constants.Fonts.mediumTextSize, weight: .regular)
        ]
        attributedPlaceholder = NSAttributedString(string: placeholder,
                                                   attributes: attributes)
        layer.borderWidth = 0.5
        layer.borderColor = Colors.border.cgColor
        addToView(view)
    }

    // MARK: - Properties
    private func setup() {
        backgroundColor           = Colors.additionalBG
        textColor                 = Colors.accent
        adjustsFontSizeToFitWidth = true
        minimumFontSize           = 10
        autocapitalizationType    = .sentences
        layer.cornerRadius        = Constants.defaultCornerRadius
        layer.borderWidth         = 0.5
        layer.borderColor         = Colors.border.cgColor

        setLeftPaddingPoints(Constants.textFieldPadding)
    }

    private func addToView(_ view: UIView) {
        view.addSubview(self)
        translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            heightAnchor.constraint(equalToConstant: 44),
            leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16)
        ])
    }
}
