import UIKit

class SelectSymbolsView: UIView {

    // MARK: - Properties
    let laundrySymbolsView = LaundrySymbolsView(frame: UIScreen.main.bounds)
    var nextButton: NextButton!
    var nextButtonHandler: (() -> Void)?

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLaundrySymbolsViewConstraints()
        setupNextButton()
        backgroundColor = Colors.lightGrayBGColor
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    // MARK: - NextButton
    private func setupNextButton() {
        nextButton = NextButton(title: "Save", action: #selector(nextButtonPressed), addTo: self)
        NSLayoutConstraint.activate([nextButton.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -8)])
    }
}

// MARK: - Actions
extension SelectSymbolsView {

    @objc func nextButtonPressed() {
        nextButtonHandler?()
    }
}

// MARK: - Constraints
extension SelectSymbolsView {

    private func setupLaundrySymbolsViewConstraints() {
        addSubview(laundrySymbolsView)
        laundrySymbolsView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([laundrySymbolsView.leadingAnchor.constraint(equalTo: leadingAnchor),
                                     laundrySymbolsView.trailingAnchor.constraint(equalTo: trailingAnchor),
                                     laundrySymbolsView.topAnchor.constraint(equalTo: topAnchor),
                                     laundrySymbolsView.bottomAnchor.constraint(equalTo: bottomAnchor)])
    }
}
