import UIKit

class CustomTextField: UITextField {

    init(placeholder: String, addTo view: UIView) {
        super.init(frame: .zero)
        backgroundColor        = Colors.lightGrayBGColor
        attributedPlaceholder  = NSAttributedString(string: placeholder,
                                                    attributes: [NSAttributedString.Key.foregroundColor: Colors.grayTextColor,
                                                                 NSAttributedString.Key.font: UIFont.systemFont(ofSize: Constants.Fonts.mediumTextSize, weight: .regular)])
        textColor              = Colors.blackTextColor
        layer.cornerRadius     = Constants.defaultCornerRadius
        autocapitalizationType = .none
        setLeftPaddingPoints(Constants.textFieldPadding)
        CustomBorder.createDefaultBorder(target: layer)
        addToView(view)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func addToView(_ view: UIView) {
        view.addSubview(self)

        translatesAutoresizingMaskIntoConstraints                                  = false
        heightAnchor.constraint(equalToConstant: 50).isActive                      = true
        leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16).isActive    = true
        trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16).isActive = true
    }
}
