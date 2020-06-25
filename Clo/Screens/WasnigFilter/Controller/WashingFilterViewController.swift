import UIKit

class WashingFilterViewController: UIViewController {

    // MARK: - Properties
    private let customView = WashingFilterView(frame: UIScreen.main.bounds)
    private let descriptionText = [
        "Color",
        "Temperature",
        "Washing mode"
    ]
    private var color: ColorType!
    private var temperature: Int!
    private var washingMode: WashingMode!
    var referenceClothes: Clothes?

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }

    // MARK: - Functions
    private func view() -> WashingFilterView {
        return view as! WashingFilterView
    }

    private func setupView() {
        view = customView
        view().delegate = self
        view().nextButton.enableButton(isOn: false)
        fillInfoAtButtons()
    }

    private func fillInfoAtButtons() {
        guard let clothes = referenceClothes else { return }

        view().nextButton.enableButton(isOn: true)

        color = clothes.color
        let attributedTitleForColor = view().colorButton.createAttributes(text: color.rawValue, textColor: Colors.accent)
        view().colorButton.setAttributedTitle(attributedTitleForColor, for: .normal)

        if let clothesWashingTemperature = WashingManager.getTemperature(clothes: clothes) {
            temperature = clothesWashingTemperature
            let attributedTitleForTemperature = view().temperatureButton.createAttributes(text: String(temperature), textColor: Colors.accent)
            view().temperatureButton.setAttributedTitle(attributedTitleForTemperature, for: .normal)
        }

        if let clothesWashingMode = WashingManager.getWashingMode(clothes: clothes) {
            washingMode = clothesWashingMode
            let attributedTitleForWashingMode = view().washingModeButton.createAttributes(text: washingMode.rawValue, textColor: Colors.accent)
            view().washingModeButton.setAttributedTitle(attributedTitleForWashingMode, for: .normal)
        }
    }

    private func checkFields() {
        guard color != nil,
            temperature != nil,
            washingMode != nil else { return }
        view().nextButton.enableButton(isOn: true)
    }

    private func collectClothes() {
        let clothes = CoreDataManager.shared.fetch { _ in }
        var washingManager = WashingManager(clothes: clothes,
                                            temperature: temperature,
                                            color: color,
                                            washingMode: washingMode,
                                            coincidence: view().switcher.isOn)
        presentResult(clothes: washingManager.filterClothes())
    }

    private func presentResult(clothes: [Clothes]?) {
        let navigationController = UINavigationController(rootViewController: ResultViewController(clothes: clothes))
        navigationController.modalPresentationStyle = .fullScreen
        present(navigationController, animated: true)
    }
}

extension WashingFilterViewController: WashingFilterViewDelegate {
    func colorButtonPressed() {
        let colorsString = ClothingColor.getAllClothingColors().map { $0.type.rawValue }
        let colorsSheet = ItemSheet(items: colorsString)
        colorsSheet.itemViewController.delegate = self
        present(colorsSheet.sheet, animated: false)
    }

    func temperatureButtonPressed() {
        let temperatures = [ "30", "40", "50", "60", "70", "95"]
        let temperatureSheet = ItemSheet(items: temperatures)
        temperatureSheet.itemViewController.delegate = self
        present(temperatureSheet.sheet, animated: false)
    }

    func washingModeButtonPressed() {
        let washingModes = WashingMode.allCases.map { $0.rawValue }
        let washingModesSheet = ItemSheet(items: washingModes)
        washingModesSheet.itemViewController.delegate = self
        present(washingModesSheet.sheet, animated: false)
    }

    func nextButtonPressed() {
        collectClothes()
    }
}

extension WashingFilterViewController: ItemViewControllerDelegate {
    func applySelectedItem(with item: String) {
        let attributedTitle = view().colorButton.createAttributes(text: item, textColor: Colors.accent)
        if let color = ColorType(rawValue: item) {
            view().colorButton.setAttributedTitle(attributedTitle, for: .normal)
            self.color = color
        }
        if let temperature = Int(item) {
            view().temperatureButton.setAttributedTitle(attributedTitle, for: .normal)
            self.temperature = temperature
        }
        if let washingMode = WashingMode(rawValue: item) {
            view().washingModeButton.setAttributedTitle(attributedTitle, for: .normal)
            self.washingMode = washingMode
        }
        checkFields()
    }
}
