import UIKit

class NextButton: UIButton {
    
    init(title: String, action: Selector, addTo view: UIView) {
        super.init(frame: .zero)
        backgroundColor    = Colors.mintColor
        layer.cornerRadius = Constants.defaultCornerRadius
        titleLabel?.font   = .systemFont(ofSize: Constants.Fonts.mediumTextSize, weight: .semibold)
        setTitleColor(.white, for: .normal)
        setTitle(title, for: .normal)
        addTarget(view, action: action, for: .touchUpInside)
        addToView(view)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func addToView(_ view: UIView) {
        view.addSubview(self)
        
        translatesAutoresizingMaskIntoConstraints                                                      = false
        heightAnchor.constraint(equalToConstant: 52).isActive                                          = true
        leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16).isActive                   = true
        trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16).isActive                = true
    }
    
    func enableButton(isOn: Bool) {
        UIView.animate(withDuration: Constants.animationTimeInterval) {
            let alphaValue: CGFloat = isOn ? 1 : 0.5
            self.alpha              = alphaValue
            self.isEnabled          = isOn
        }
    }
}
