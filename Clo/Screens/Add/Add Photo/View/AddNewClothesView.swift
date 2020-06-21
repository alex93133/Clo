import UIKit

// MARK: - Delegate

protocol AddNewClothesViewDelegate: class {
    func addPhotoButtonPressed()
}

class AddNewClothesView: UIView {
    // MARK: - Properties
    weak var delegate: AddNewClothesViewDelegate!
    var addPhotoButton: UIButton!
    var blurEffectView: UIVisualEffectView!

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupAddPhotoNextButton()
        backgroundColor = Colors.lightGrayBGColor
        setupBlurEffectView()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    // MARK: - ApplyBlurEffect
    func applyBlurEffect(_ show: Bool) {
        UIView.animate(withDuration: Constants.animationTimeInterval) { [weak self] in
            if show {
                self.blurEffectView.alpha = 1
            } else {
                self.blurEffectView.alpha = 0
            }
        }
    }

    // MARK: - BlurEffectView
    private func setupBlurEffectView() {
        let blurEffect = UIBlurEffect(style: .light)
        blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = frame
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        blurEffectView.backgroundColor = Colors.overlayColor
        blurEffectView.alpha = 0
        addSubview(blurEffectView)
    }

    // MARK: - AddPhotoNextButton
    private func setupAddPhotoNextButton() {
        addPhotoButton = UIButton()
        addPhotoButton.backgroundColor = Colors.whiteBGColor
        addPhotoButton.layer.cornerRadius = Constants.defaultCornerRadius
        addPhotoButton.titleLabel?.font = .systemFont(ofSize: Constants.fonts.mediumTextSize, weight: .semibold)
        addPhotoButton.setTitleColor(Colors.blackTextColor, for: .normal)
        addPhotoButton.setTitle("Add photo", for: .normal)
        addPhotoButton.addTarget(self, action: #selector(addPhotoButtonPressed), for: .touchUpInside)
        setupAddPhotoButtonConstraints()
    }

    // MARK: - Actions
    @objc
    func addPhotoButtonPressed() {
        delegate.addPhotoButtonPressed()
    }

    // MARK: - Constraints
    private func setupAddPhotoButtonConstraints() {
        addSubview(addPhotoButton)

        addPhotoButton.translatesAutoresizingMaskIntoConstraints = false
        addPhotoButton.heightAnchor.constraint(equalToConstant: 56).isActive = true
        addPhotoButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16).isActive = true
        addPhotoButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16).isActive = true
        addPhotoButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -250).isActive = true
    }
}
