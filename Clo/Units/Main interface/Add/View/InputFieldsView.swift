import UIKit

class InputFieldsView: UIView {

    // MARK: - Properties
    var descriptionTextView: UITextView!
    var selectTypeButton: UIButton!

    override init(frame: CGRect) {
        super.init(frame: frame)

        createInputLabels(text: "Clothing type",
                          topDistance: 231)
        createInputLabels(text: "Description",
                          topDistance: 327)
        createInputLabels(text: "Select color",
                          topDistance: 443)
        setupDescriptionTextView()
        setupSelectTypeButton()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    // MARK: - Border
    static func createDefaultBorder(target layer: CALayer) {
        layer.borderWidth = 0.5
        layer.borderColor = Colors.separator
    }

    // MARK: - InputLabels
    private func createInputLabels(text: String, topDistance: CGFloat) {
        let label       = UILabel()
        label.text      = text
        label.font      = .systemFont(ofSize: Constants.Fonts.smallTextSize, weight: .regular)
        label.textColor = Colors.grayTextColor

        addSubview(label)

        label.translatesAutoresizingMaskIntoConstraints                                  = false
        label.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 12).isActive    = true
        label.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -12).isActive = true
        label.heightAnchor.constraint(equalToConstant: 18).isActive                      = true
        label.topAnchor.constraint(equalTo: topAnchor, constant: topDistance).isActive   = true
    }

    // MARK: - DescriptionTextView
    private func setupDescriptionTextView() {
        descriptionTextView                    = UITextView()
        descriptionTextView.toolbarPlaceholder = "Enter the short description"
        descriptionTextView.font               = .systemFont(ofSize: Constants.Fonts.mediumTextSize, weight: .regular)
        descriptionTextView.textColor          = Colors.grayTextColor
        descriptionTextView.backgroundColor    = Colors.lightGrayBGColor
        descriptionTextView.layer.cornerRadius = Constants.customLoginButtonCornerRadius
        descriptionTextView.contentInset       = UIEdgeInsets(top: 12, left: 12, bottom: 12, right: 12)
        InputFieldsView.createDefaultBorder(target: descriptionTextView.layer)

        setupDescriptionFieldConstraints()
    }

    // MARK: - SelectTypeButton
    private func setupSelectTypeButton() {
        selectTypeButton                            = UIButton()
        selectTypeButton.backgroundColor            = Colors.lightGrayBGColor
        selectTypeButton.layer.cornerRadius         = Constants.customLoginButtonCornerRadius
        selectTypeButton.contentHorizontalAlignment = .left
        selectTypeButton.titleEdgeInsets            = UIEdgeInsets(top: 0, left: 12, bottom: 0, right: 12)
        selectTypeButton.addTarget(self, action: #selector(selectTypeButtonPressed), for: .touchUpInside)

        let attributedString = NSMutableAttributedString(string: "Select type")
        attributedString.addAttribute(NSAttributedString.Key.font,
                                      value: UIFont.systemFont(ofSize: Constants.Fonts.mediumTextSize, weight: .regular),
                                      range: NSRange(location: 0, length: attributedString.length))
        attributedString.addAttribute(NSAttributedString.Key.foregroundColor,
                                      value: Colors.grayTextColor,
                                      range: NSRange(location: 0, length: attributedString.length))
        selectTypeButton.setAttributedTitle(attributedString, for: .normal)
        InputFieldsView.createDefaultBorder(target: selectTypeButton.layer)

        setupSelectTypeButtonConstraints()
    }
}

// MARK: - Constraints
extension InputFieldsView {

    private func setupDescriptionFieldConstraints() {
        addSubview(descriptionTextView)

        descriptionTextView.translatesAutoresizingMaskIntoConstraints                                  = false
        descriptionTextView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 12).isActive    = true
        descriptionTextView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -12).isActive = true
        descriptionTextView.heightAnchor.constraint(equalToConstant: 64).isActive                      = true
        descriptionTextView.topAnchor.constraint(equalTo: topAnchor, constant: 355).isActive           = true
    }

    private func setupSelectTypeButtonConstraints() {
        addSubview(selectTypeButton)

        selectTypeButton.translatesAutoresizingMaskIntoConstraints                                  = false
        selectTypeButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 12).isActive    = true
        selectTypeButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -12).isActive = true
        selectTypeButton.heightAnchor.constraint(equalToConstant: 44).isActive                      = true
        selectTypeButton.topAnchor.constraint(equalTo: topAnchor, constant: 259).isActive           = true
    }
}

// MARK: - Actions
extension InputFieldsView {

    @objc func selectTypeButtonPressed() {
        print("Clicked")
    }
}
