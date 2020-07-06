import UIKit

class LaundryListView: UIView {

    // MARK: - Properties
    private var addButton: UIButton!
    var addButtonHandler: (() -> Void)!
    private var shadowView: CloShadowView!

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupContainerView()
        setupAddButton()
        backgroundColor = Colors.mainBG
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    // MARK: - ContainerView
    private func setupContainerView() {
        shadowView = CloShadowView()
        setupShadowViewConstraints()
    }

    // MARK: - AddButton
    private func setupAddButton() {
        addButton = UIButton()

        let attributedString = NSMutableAttributedString(string: NSLocalizedString("Add new item", comment: ""))
        attributedString.addAttribute(NSAttributedString.Key.font,
                                      value: UIFont.systemFont(ofSize: Constants.Fonts.largeTextSize, weight: .medium),
                                      range: NSRange(location: 0, length: attributedString.length))
        attributedString.addAttribute(NSAttributedString.Key.foregroundColor,
                                      value: UIColor.white,
                                      range: NSRange(location: 0, length: attributedString.length))

        addButton.setAttributedTitle(attributedString, for: .normal)
        addButton.addTarget(self, action: #selector(addButtonPressed), for: .touchUpInside)
        addButton.setBackgroundImage(Images.addNewLaundry, for: .normal)

        setupAddButtonConstraints()
    }

    // MARK: - Actions
    @objc
    private func addButtonPressed() {
        addButtonHandler()
    }

    // MARK: - Constraints
    private func setupShadowViewConstraints() {
        addSubview(shadowView)
        shadowView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            shadowView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 12),
            shadowView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -12),
            shadowView.topAnchor.constraint(equalTo: topAnchor, constant: 8),
            shadowView.heightAnchor.constraint(equalTo: shadowView.widthAnchor, multiplier: 2 / 9)
        ])
    }

    private func setupAddButtonConstraints() {
        shadowView.containerView.addSubview(addButton)
        addButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            addButton.leadingAnchor.constraint(equalTo: shadowView.leadingAnchor),
            addButton.topAnchor.constraint(equalTo: shadowView.topAnchor),
            addButton.trailingAnchor.constraint(equalTo: shadowView.trailingAnchor),
            addButton.bottomAnchor.constraint(equalTo: shadowView.bottomAnchor)
        ])
    }
}
