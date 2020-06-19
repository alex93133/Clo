import UIKit

class CustomTextField: UITextField {

    override init(frame: CGRect) {
        super.init(frame: .zero)
        setup()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    convenience init(placeholder: String, addTo view: UIView) {
        self.init(frame: .zero)
        attributedPlaceholder  = NSAttributedString(string: placeholder,
                                                    attributes: [NSAttributedString.Key.foregroundColor: Colors.grayTextColor,
                                                                 NSAttributedString.Key.font: UIFont.systemFont(ofSize: Constants.Fonts.mediumTextSize, weight: .regular)])
        layer.borderWidth = 0.5
        layer.borderColor = Colors.separator.cgColor
        addToView(view)
    }

    private func setup() {
        backgroundColor        = Colors.lightGrayBGColor
        textColor              = Colors.blackTextColor
        layer.cornerRadius     = Constants.defaultCornerRadius
        autocapitalizationType = .none
        setLeftPaddingPoints(Constants.textFieldPadding)
    }

    private func addToView(_ view: UIView) {
        view.addSubview(self)
        translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([heightAnchor.constraint(equalToConstant: 64),
                                     leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
                                     trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16)])
    }
}
