import UIKit

class CloNewItemButton: UIButton {

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
        let attributedString = createAttributes(text: title)
        setAttributedTitle(attributedString, for: .normal)
    }

    private func setup() {
        setBackgroundImage(Images.addNewLaundry, for: .normal)
        layer.cornerRadius  = Constants.defaultCornerRadius
        layer.masksToBounds =  true
    }


    private func createAttributes(text: String) -> NSMutableAttributedString {
        let attributedString = NSMutableAttributedString(string: text)
        attributedString.addAttribute(NSAttributedString.Key.font,
                                      value: UIFont.systemFont(ofSize: Constants.Fonts.largeTextSize, weight: .medium),
                                      range: NSRange(location: 0, length: attributedString.length))
        attributedString.addAttribute(NSAttributedString.Key.foregroundColor,
                                      value: UIColor.white,
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
            topAnchor.constraint(equalTo: view.topAnchor, constant: 8),
            heightAnchor.constraint(equalTo: widthAnchor, multiplier: 2 / 9)
        ])
    }
}
