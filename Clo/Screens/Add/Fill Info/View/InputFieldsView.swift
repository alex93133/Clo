import UIKit

class InputFieldsView: UIView {

    // MARK: - Properties
    var descriptionTextField: UITextField!
    var selectTypeButton: CloFieldButton!
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
        label.textColor = Colors.textGray

        addSubview(label)

        label.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            label.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 12),
            label.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -12),
            label.heightAnchor.constraint(equalToConstant: 18)
        ])

        return label
    }

    // MARK: - DescriptionTextField
    private func setupDescriptionTextField() {
        descriptionTextField = CloTextField(placeholder: NSLocalizedString("Enter the short description", comment: ""),
                                            addTo: self)
        descriptionTextField.adjustsFontSizeToFitWidth = true
        descriptionTextField.minimumFontSize           = 10
        descriptionTextField.autocapitalizationType    = .sentences
        descriptionTextField.layer.borderWidth         = 0.5
        descriptionTextField.layer.borderColor         = Colors.border.cgColor
        setupDescriptionFieldConstraints()
    }

    // MARK: - SelectTypeButton
    private func setupSelectTypeButton() {
        selectTypeButton = CloFieldButton(title: NSLocalizedString("Select type", comment: ""),
                                          action: #selector(selectTypeButtonPressed),
                                          addTo: self)
        NSLayoutConstraint.activate([selectTypeButton.topAnchor.constraint(equalTo: topAnchor, constant: 40)])
    }

    // MARK: - Constraints
    private func setupDescriptionFieldConstraints() {
        addSubview(descriptionTextField)
        descriptionTextField.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            descriptionTextField.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 12),
            descriptionTextField.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -12),
            descriptionTextField.heightAnchor.constraint(equalToConstant: 44),
            descriptionTextField.topAnchor.constraint(equalTo: topAnchor, constant: 136)
        ])
    }

    private func placeLabels() {
        let label1 = createInputLabels(text: NSLocalizedString("Clothing type", comment: ""))
        let label2 = createInputLabels(text: NSLocalizedString("Description (optional)", comment: ""))
        let label3 = createInputLabels(text: NSLocalizedString("Select color", comment: ""))
        NSLayoutConstraint.activate([
            label1.topAnchor.constraint(equalTo: topAnchor, constant: 12),
            label2.topAnchor.constraint(equalTo: selectTypeButton.bottomAnchor, constant: 24),
            label3.topAnchor.constraint(equalTo: descriptionTextField.bottomAnchor, constant: 24)
        ])
    }

    // MARK: - Actions
    @objc
    func selectTypeButtonPressed() {
        selectTypeButton.dropDownIcon.rotate()
        selectTypeButtonHandler?()
    }
}
