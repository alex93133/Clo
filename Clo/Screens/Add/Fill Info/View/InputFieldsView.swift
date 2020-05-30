import UIKit

class InputFieldsView: UIView {
    
    // MARK: - Properties
    var descriptionTextField: UITextField!
    var selectTypeButton: UIButton!
    
    var selectTypeButtonHandler: (() -> Void)?
    
    init() {
        super.init(frame: .zero)
        setupDescriptionTextField()
        setupSelectTypeButton()
        placeLabels()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    // MARK: - InputLabels
    private func createInputLabels(text: String) -> UILabel {
        let label       = UILabel()
        label.text      = text
        label.font      = .systemFont(ofSize: Constants.Fonts.smallTextSize, weight: .regular)
        label.textColor = Colors.grayTextColor
        
        addSubview(label)
        
        label.translatesAutoresizingMaskIntoConstraints                                  = false
        label.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 12).isActive    = true
        label.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -12).isActive = true
        label.heightAnchor.constraint(equalToConstant: 18).isActive                      = true
        
        return label
    }
    
    // MARK: - DescriptionTextField
    private func setupDescriptionTextField() {
        descriptionTextField = CustomTextField(placeholder: "Enter the short description", addTo: self)
        descriptionTextField.adjustsFontSizeToFitWidth = true
        descriptionTextField.minimumFontSize = 10
        descriptionTextField.autocapitalizationType = .sentences
        CustomBorder.createDefaultBorder(target: descriptionTextField.layer)
        
        setupDescriptionFieldConstraints()
    }
    
    // MARK: - SelectTypeButton
    func createAttributes(text: String, textColor: UIColor) -> NSMutableAttributedString {
        let attributedString = NSMutableAttributedString(string: text)
        attributedString.addAttribute(NSAttributedString.Key.font,
                                      value: UIFont.systemFont(ofSize: Constants.Fonts.mediumTextSize, weight: .regular),
                                      range: NSRange(location: 0, length: attributedString.length))
        attributedString.addAttribute(NSAttributedString.Key.foregroundColor,
                                      value: textColor,
                                      range: NSRange(location: 0, length: attributedString.length))
        return attributedString
    }
    
    private func setupSelectTypeButton() {
        selectTypeButton                            = UIButton()
        selectTypeButton.backgroundColor            = Colors.lightGrayBGColor
        selectTypeButton.layer.cornerRadius         = Constants.defaultCornerRadius
        selectTypeButton.contentHorizontalAlignment = .left
        selectTypeButton.titleEdgeInsets            = UIEdgeInsets(top: 0, left: 12, bottom: 0, right: 12)
        selectTypeButton.addTarget(self, action: #selector(selectTypeButtonPressed), for: .touchUpInside)
        let attributedString = createAttributes(text: "Select type", textColor: Colors.grayTextColor)
        selectTypeButton.setAttributedTitle(attributedString, for: .normal)
        CustomBorder.createDefaultBorder(target: selectTypeButton.layer)
        
        setupSelectTypeButtonConstraints()
    }
}

// MARK: - Constraints
extension InputFieldsView {
    
    private func setupDescriptionFieldConstraints() {
        addSubview(descriptionTextField)
        
        descriptionTextField.translatesAutoresizingMaskIntoConstraints                                  = false
        descriptionTextField.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 12).isActive    = true
        descriptionTextField.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -12).isActive = true
        descriptionTextField.heightAnchor.constraint(equalToConstant: 64).isActive                      = true
        descriptionTextField.topAnchor.constraint(equalTo: topAnchor, constant: 136).isActive           = true
    }
    
    private func setupSelectTypeButtonConstraints() {
        addSubview(selectTypeButton)
        
        selectTypeButton.translatesAutoresizingMaskIntoConstraints                                  = false
        selectTypeButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 12).isActive    = true
        selectTypeButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -12).isActive = true
        selectTypeButton.heightAnchor.constraint(equalToConstant: 44).isActive                      = true
        selectTypeButton.topAnchor.constraint(equalTo: topAnchor, constant: 40).isActive            = true
    }
    
    private func placeLabels() {
        let label1 = createInputLabels(text: "Clothing type")
        let label2 = createInputLabels(text: "Description")
        let label3 = createInputLabels(text: "Select color")
        label1.topAnchor.constraint(equalTo: topAnchor, constant: 12).isActive                         = true
        label2.topAnchor.constraint(equalTo: selectTypeButton.bottomAnchor, constant: 24).isActive     = true
        label3.topAnchor.constraint(equalTo: descriptionTextField.bottomAnchor, constant: 24).isActive = true
    }
}

// MARK: - Actions
extension InputFieldsView {
    
    @objc func selectTypeButtonPressed() {
        selectTypeButtonHandler?()
    }
}
