import UIKit

class CloFieldButton: UIButton {

    // MARK: - Properties
    var dropDownIcon: UIImageView!

    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }

    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    convenience init(title: String, action: Selector, addTo view: UIView) {
        self.init(frame: .zero)
        addTarget(view, action: action, for: .touchUpInside)
        addToView(view)
        setupDropDownIcon()
        let attributedString = createAttributes(text: title, textColor: Colors.textGray)
        setAttributedTitle(attributedString, for: .normal)
    }

    private func setup() {
        backgroundColor            = Colors.additionalBG
        layer.cornerRadius         = Constants.defaultCornerRadius
        layer.borderWidth          = 0.5
        layer.borderColor          = Colors.border.cgColor
        contentHorizontalAlignment = .left
        titleEdgeInsets            = UIEdgeInsets(top: 0, left: 12, bottom: 0, right: 12)
    }

    // MARK: - DropDownIcon
    private func setupDropDownIcon() {
        dropDownIcon             = UIImageView()
        dropDownIcon.image       = Images.dropDownIcon
        dropDownIcon.contentMode = .scaleAspectFill
        dropDownIcon.tintColor   = Colors.textGray

        setupDropDownIconConstraints()
    }

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

    // MARK: - Constraints
    private func addToView(_ view: UIView) {
        view.addSubview(self)
        translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 12),
            trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -12),
            heightAnchor.constraint(equalToConstant: 44)
        ])
    }

    private func setupDropDownIconConstraints() {
        addSubview(dropDownIcon)
        dropDownIcon.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            dropDownIcon.widthAnchor.constraint(equalToConstant: 14),
            dropDownIcon.heightAnchor.constraint(equalToConstant: 7),
            dropDownIcon.centerYAnchor.constraint(equalTo: centerYAnchor),
            dropDownIcon.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -15)
        ])
    }
}
