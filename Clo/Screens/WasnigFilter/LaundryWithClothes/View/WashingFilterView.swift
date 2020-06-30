import UIKit

protocol WashingFilterViewDelegate: class {
    func colorButtonPressed()
    func temperatureButtonPressed()
    func washingModeButtonPressed()
    func nextButtonPressed()
}

class WashingFilterView: UIView {

    // MARK: - Properties
    private var coincidenceLabel: UILabel!
    private var line: UIView!
    var coWashLabel: UILabel!
    var colorButton: CloFieldButton!
    var colorLabel: UILabel!
    var headLabel: UILabel!
    var laundryNameLabel: UILabel!
    var nameTextField: CloTextField!
    var nextButton: CloNextButton!
    var switcher: UISwitch!
    var temperatureButton: CloFieldButton!
    var temperatureLabel: UILabel!
    var washingModeButton: CloFieldButton!
    var washingModeLabel: UILabel!
    weak var delegate: WashingFilterViewDelegate?

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupHeadLabel()
        setupFieldDescriptionLabel()
        setupFieldButtons()
        setupNameTextField()
        setupLine()
        setupCoincidenceLabel()
        setupSwitcher()
        setupNextButton()
        backgroundColor = Colors.mainBG
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    // MARK: - HeadLabel
    private func setupHeadLabel() {
        headLabel               = UILabel()
        headLabel.text          = NSLocalizedString("Collect the wash", comment: "")
        headLabel.textColor     = Colors.accent
        headLabel.font          = .systemFont(ofSize: Constants.Fonts.headTextSize, weight: .bold)
        headLabel.textAlignment = .center
        setupHeadLabelConstraints()
    }

    // MARK: - Line
    private func setupLine() {
        line = UIView()
        line.backgroundColor = Colors.border
        setupLineConstraints()
    }

    // MARK: - FieldDescriptionLabel
    private func createFieldDescriptionLabel(text: String) -> UILabel {
        let fieldDescriptionLabel           = UILabel()
        fieldDescriptionLabel.text          = text
        fieldDescriptionLabel.textColor     = Colors.textGray
        fieldDescriptionLabel.textAlignment = .left
        fieldDescriptionLabel.font          = .systemFont(ofSize: Constants.Fonts.smallTextSize, weight: .regular)
        setupFieldDescriptionLabelConstraints(label: fieldDescriptionLabel)
        return fieldDescriptionLabel
    }

    private func setupFieldDescriptionLabel() {
        colorLabel       = createFieldDescriptionLabel(text: NSLocalizedString("Color ", comment: ""))
        temperatureLabel = createFieldDescriptionLabel(text: NSLocalizedString("Temperature", comment: ""))
        washingModeLabel = createFieldDescriptionLabel(text: NSLocalizedString("Washing mode", comment: ""))
        coWashLabel      = createFieldDescriptionLabel(text: NSLocalizedString("Co-wash", comment: ""))
        laundryNameLabel = createFieldDescriptionLabel(text: NSLocalizedString("Laundry name", comment: ""))

        laundryNameLabel.isHidden = true

        NSLayoutConstraint.activate([
            colorLabel.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 44),
            temperatureLabel.topAnchor.constraint(equalTo: colorLabel.bottomAnchor, constant: 76),
            washingModeLabel.topAnchor.constraint(equalTo: temperatureLabel.bottomAnchor, constant: 76),
            laundryNameLabel.topAnchor.constraint(equalTo: washingModeLabel.bottomAnchor, constant: 76),
            coWashLabel.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -150)
        ])
    }

    // MARK: - FieldButtons
    private func setupFieldButtons() {
        colorButton       = CloFieldButton(title: NSLocalizedString("Select color",
                                                                    comment: ""),
                                           action: #selector(colorButtonPressed),
                                           addTo: self)
        temperatureButton = CloFieldButton(title: NSLocalizedString("Select temperature",
                                                                    comment: ""),
                                           action: #selector(temperatureButtonPressed),
                                           addTo: self)
        washingModeButton = CloFieldButton(title: NSLocalizedString("Select washing mode",
                                                                    comment: ""),
                                           action: #selector(washingModeButtonPressed),
                                           addTo: self)
        NSLayoutConstraint.activate([
            colorButton.topAnchor.constraint(equalTo: colorLabel.bottomAnchor, constant: 8),
            temperatureButton.topAnchor.constraint(equalTo: colorButton.bottomAnchor, constant: 50),
            washingModeButton.topAnchor.constraint(equalTo: temperatureButton.bottomAnchor, constant: 50)
        ])
    }

    // MARK: - NameTextField
    private func setupNameTextField() {
        nameTextField = CloTextField(placeholder: NSLocalizedString("Enter name", comment: ""), addTo: self)
        NSLayoutConstraint.activate([
            nameTextField.topAnchor.constraint(equalTo: washingModeButton.bottomAnchor, constant: 50)
        ])
        nameTextField.isHidden = true
    }

    // MARK: - CoincidenceLabel
    private func setupCoincidenceLabel() {
        coincidenceLabel           = UILabel()
        coincidenceLabel.text      = NSLocalizedString("Ideal coincidence", comment: "")
        coincidenceLabel.textColor = Colors.accent
        coincidenceLabel.font      = .systemFont(ofSize: Constants.Fonts.mediumTextSize, weight: .regular)
        setupCoincidenceLabelConstraints()
    }

    // MARK: - Switcher
    private func setupSwitcher() {
        switcher             = UISwitch()
        switcher.onTintColor = Colors.mint
        setupSwitcherConstraints()
    }

    // MARK: - NextButton
    private func setupNextButton() {
        nextButton = CloNextButton(title: NSLocalizedString("Collect", comment: ""),
                                   action: #selector(nextButtonPressed),
                                   addTo: self)
        NSLayoutConstraint.activate([
            nextButton.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -8)
        ])
    }

    // MARK: - Actions
    @objc
    func colorButtonPressed() {
        colorButton.dropDownIcon.rotate()
        delegate?.colorButtonPressed()
    }
    @objc
    func temperatureButtonPressed() {
        temperatureButton.dropDownIcon.rotate()
        delegate?.temperatureButtonPressed()
    }
    @objc
    func washingModeButtonPressed() {
        washingModeButton.dropDownIcon.rotate()
        delegate?.washingModeButtonPressed()
    }

    @objc
    func nextButtonPressed() {
        delegate?.nextButtonPressed()
    }

    // MARK: - Constraints
    private func setupHeadLabelConstraints() {
        addSubview(headLabel)
        headLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            headLabel.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            headLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 12),
            headLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -12),
            headLabel.heightAnchor.constraint(equalToConstant: 28)
        ])
    }

    private func setupFieldDescriptionLabelConstraints(label: UILabel) {
        addSubview(label)
        label.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            label.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 12),
            label.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -12),
            label.heightAnchor.constraint(equalToConstant: 18)
        ])
    }

    private func setupLineConstraints() {
        addSubview(line)
        line.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            line.heightAnchor.constraint(equalToConstant: 0.5),
            line.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 12),
            line.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -12),
            line.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -186)
        ])
    }

    private func setupCoincidenceLabelConstraints() {
        addSubview(coincidenceLabel)
        coincidenceLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            coincidenceLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 12),
            coincidenceLabel.heightAnchor.constraint(equalToConstant: 22),
            coincidenceLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -75),
            coincidenceLabel.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -115)
        ])
    }

    private func setupSwitcherConstraints() {
        addSubview(switcher)
        switcher.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            switcher.widthAnchor.constraint(equalToConstant: 60),
            switcher.heightAnchor.constraint(equalToConstant: 30),
            switcher.centerYAnchor.constraint(equalTo: coincidenceLabel.centerYAnchor),
            switcher.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -12)
        ])
    }
}
