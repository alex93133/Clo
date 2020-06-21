import UIKit

class ForgotPasswordView: UIView {
    // MARK: - Properties
    var headLabel: UILabel!
    var messageLabel: UILabel!
    var emailTextField: UITextField!
    var forgotButton: UIButton!

    var forgotButtonHandler: (() -> Void)!

    // MARK: - LoginLabel
    private func setupHeadLabel() {
        headLabel = UILabel()
        headLabel.text = "Forgot password?"
        headLabel.font = .systemFont(ofSize: Sizes.fonts.headTextSize, weight: .heavy)
        headLabel.textColor = Colors.blackTextColor
        headLabel.textAlignment = .center
        setupHeadLabelConstraints()
    }

    // MARK: - MessageLabel
    private func setupMessageLabel() {
        messageLabel = UILabel()
        messageLabel.text = "to recover your password enter your email"
        messageLabel.font = .systemFont(ofSize: Sizes.fonts.smallTextSize, weight: .regular)
        messageLabel.textColor = Colors.grayTextColor
        messageLabel.textAlignment = .center
        setupMessageLabelConstraints()
    }

    // MARK: - EmailTextField
    private func setupEmailTextField() {
        emailTextField = AuthView.createTextField(placeholder: "Email")
        emailTextField.textContentType = .emailAddress
        setupEmailTextFieldConstraints()
    }

    // MARK: - NextButton
    private func setupNextButton() {
        forgotButton = UIButton()
        forgotButton.backgroundColor = Colors.mintColor
        forgotButton.layer.cornerRadius = Sizes.defaultCornerRadius
        forgotButton.titleLabel?.font = .systemFont(ofSize: Sizes.fonts.mediumTextSize, weight: .semibold)
        forgotButton.setTitleColor(.white, for: .normal)
        forgotButton.setTitle("Sign in", for: .normal)
        forgotButton.addTarget(self, action: #selector(forgotButtonPressed), for: .touchUpInside)
        setupNextButtonConstraints()
    }

    // MARK: - Actions
    @objc
    func forgotButtonPressed() {
        forgotButtonHandler()
    }
}
