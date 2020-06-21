import UIKit

class SelectSymbolsView: UIView {

    // MARK: - Properties
    let laundrySymbolsView = LaundrySymbolsView(frame: UIScreen.main.bounds)
    var nextButton: CloNextButton!
    var nextButtonHandler: (() -> Void)?

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLaundrySymbolsViewConstraints()
        setupNextButton()
        backgroundColor = Colors.additionalBG
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    // MARK: - NextButton
    private func setupNextButton() {
        nextButton = CloNextButton(title: "Save", action: #selector(nextButtonPressed), addTo: self)
        NSLayoutConstraint.activate([nextButton.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -8)])
    }

    // MARK: - Actions
    @objc
    func nextButtonPressed() {
        nextButtonHandler?()
    }

    // MARK: - Constraints
    private func setupLaundrySymbolsViewConstraints() {
        addSubview(laundrySymbolsView)
        laundrySymbolsView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            laundrySymbolsView.leadingAnchor.constraint(equalTo: leadingAnchor),
            laundrySymbolsView.trailingAnchor.constraint(equalTo: trailingAnchor),
            laundrySymbolsView.topAnchor.constraint(equalTo: topAnchor),
            laundrySymbolsView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
}
