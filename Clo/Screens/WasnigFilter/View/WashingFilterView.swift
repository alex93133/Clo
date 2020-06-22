import UIKit

protocol WashingFilterViewDelegate: class {
    func colorButtonPressed()
    func temperatureButtonPressed()
    func washingModeButtonPressed()
    func nextButtonPressed()
}

class WashingFilterView: UIView {

    // MARK: - Properties
    private var headLabel: UILabel!
    var colorButton: CloFieldButton!
    var temperatureButton: CloFieldButton!
    var washingModeButton: CloFieldButton!
    private var line: UIView!
    private var coincidenceLabel: UILabel!
    var nextButton: CloNextButton!
    var switcher: UISwitch!
    weak var delegate: WashingFilterViewDelegate?

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupHeadLabel()
        setupFieldDescriptionLabel()
        setupFieldButtons()
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
        headLabel.text          = "Collect the wash"
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
        let label1 = createFieldDescriptionLabel(text: "Color")
        let label2 = createFieldDescriptionLabel(text: "Temperature")
        let label3 = createFieldDescriptionLabel(text: "Washing mode")
        let label4 = createFieldDescriptionLabel(text: "Co-wash")
        NSLayoutConstraint.activate([
            label1.topAnchor.constraint(equalTo: headLabel.bottomAnchor, constant: 24),
            label2.topAnchor.constraint(equalTo: label1.bottomAnchor, constant: 76),
            label3.topAnchor.constraint(equalTo: label2.bottomAnchor, constant: 76),
            label4.topAnchor.constraint(equalTo: label3.bottomAnchor, constant: 95)
        ])
    }

    // MARK: - FieldButtons
    private func setupFieldButtons() {
        colorButton       = CloFieldButton(title: "Select color", action: #selector(colorButtonPressed), addTo: self)
        temperatureButton = CloFieldButton(title: "Select temperature", action: #selector(temperatureButtonPressed), addTo: self)
        washingModeButton = CloFieldButton(title: "Select washing mode", action: #selector(washingModeButtonPressed), addTo: self)

        NSLayoutConstraint.activate([
            colorButton.topAnchor.constraint(equalTo: headLabel.bottomAnchor, constant: 50),
            temperatureButton.topAnchor.constraint(equalTo: colorButton.bottomAnchor, constant: 50),
            washingModeButton.topAnchor.constraint(equalTo: temperatureButton.bottomAnchor, constant: 50)
        ])
    }

    // MARK: - CoincidenceLabel
    private func setupCoincidenceLabel() {
        coincidenceLabel           = UILabel()
        coincidenceLabel.text      = "Ideal coincidence"
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
        nextButton = CloNextButton(title: "Collect",
                                   action: #selector(nextButtonPressed),
                                   addTo: self)
        NSLayoutConstraint.activate([
            nextButton.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -8)
        ])
    }

    // MARK: - Actions
    @objc
    func colorButtonPressed() {
        delegate?.colorButtonPressed()
    }
    @objc
    func temperatureButtonPressed() {
        delegate?.temperatureButtonPressed()
    }
    @objc
    func washingModeButtonPressed() {
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
            line.topAnchor.constraint(equalTo: headLabel.bottomAnchor, constant: 324)
        ])
    }

    private func setupCoincidenceLabelConstraints() {
        addSubview(coincidenceLabel)
        coincidenceLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            coincidenceLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 12),
            coincidenceLabel.heightAnchor.constraint(equalToConstant: 22),
            coincidenceLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -75),
            coincidenceLabel.topAnchor.constraint(equalTo: headLabel.bottomAnchor, constant: 355)
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
