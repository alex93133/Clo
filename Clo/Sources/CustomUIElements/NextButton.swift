import UIKit

class NextButton: UIButton {

    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    convenience init(title: String, action: Selector, addTo view: UIView) {
        self.init(frame: .zero)
        setTitle(title, for: .normal)
                addTarget(view, action: action, for: .touchUpInside)
                addToView(view)
    }

    private func setup() {
        backgroundColor    = Colors.mintColor
        layer.cornerRadius = Constants.defaultCornerRadius
        titleLabel?.font   = .systemFont(ofSize: Constants.Fonts.mediumTextSize, weight: .semibold)
        setTitleColor(.white, for: .normal)
    }

    private func addToView(_ view: UIView) {
        view.addSubview(self)

        translatesAutoresizingMaskIntoConstraints                                      = false
        heightAnchor.constraint(equalToConstant: 52).isActive                          = true
        leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 8).isActive    = true
        trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -8).isActive = true
    }

    func enableButton(isOn: Bool, minAlphaValue: CGFloat = 0.5) {
        UIView.animate(withDuration: Constants.animationTimeInterval) {
            let alphaValue: CGFloat = isOn ? 1 :minAlphaValue
            self.alpha              = alphaValue
            self.isEnabled          = isOn
        }
    }
}
