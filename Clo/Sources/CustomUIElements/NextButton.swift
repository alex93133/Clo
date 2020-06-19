import UIKit

class NextButton: UIButton {
    
    private var activityIndicator: UIActivityIndicatorView!
    private var temporaryTitle: String?
    var isProcessing: Bool  {
        get {
            return false
        }
        set {
            if newValue {
                activityIndicator.startAnimating()
                temporaryTitle = titleLabel?.text
            } else {
                activityIndicator.stopAnimating()
            }
            let newTitle = newValue ? "" : temporaryTitle
            enableButton(isOn: !newValue)
            setTitle(newTitle, for: .normal)
        }
    }
    
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
        setTitleColor(Colors.whiteColor, for: .normal)
        setupActivityIndicator()
    }
    
    private func addToView(_ view: UIView) {
        view.addSubview(self)
        translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([heightAnchor.constraint(equalToConstant: 52),
                                     leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 8),
                                     trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -8)])
    }
    
    private func setupActivityIndicator() {
        activityIndicator                  = UIActivityIndicatorView()
        activityIndicator.hidesWhenStopped = true
        activityIndicator.color            = Colors.whiteColor
        activityIndicator.center           = self.center
        addSubview(activityIndicator)
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([activityIndicator.centerYAnchor.constraint(equalTo: centerYAnchor),
                                     activityIndicator.centerXAnchor.constraint(equalTo: centerXAnchor)])
    }
    
    
    func enableButton(isOn: Bool, minAlphaValue: CGFloat = 0.5) {
        UIView.animate(withDuration: Constants.animationTimeInterval) {
            let alphaValue: CGFloat = isOn ? 1 :minAlphaValue
            self.alpha              = alphaValue
            self.isEnabled          = isOn
        }
    }
}
