import UIKit

extension ForgotPasswordViewController {
    func setup() {

        setupResetLabel()
        setupMessageLabel()
        setupEmailTextField()
        setupContinueButton()

        view.backgroundColor = Colors.viewBGColor
    }

    // MARK: - ResetLabel
    func setupResetLabel() {
        resetLabel               = UILabel()
        resetLabel.text          = "Forgot password?"
        resetLabel.textColor     = Colors.textColor
        resetLabel.font          = .systemFont(ofSize: Sizes.headTextSize, weight: .bold)
        resetLabel.textAlignment = .center

        view.addSubview(resetLabel)

        resetLabel.translatesAutoresizingMaskIntoConstraints                                       = false
        resetLabel.heightAnchor.constraint(equalToConstant: 41).isActive                           = true
        resetLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16).isActive    = true
        resetLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16).isActive = true
        resetLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 112).isActive           = true
    }

    // MARK: - MessageLabel
    func setupMessageLabel() {
        messageLabel               = UILabel()
        messageLabel.text          = "to recover your password enter your email"
        messageLabel.textColor     = Colors.textColor
        messageLabel.font          = .systemFont(ofSize: Sizes.smallTextSize, weight: .regular)
        messageLabel.textAlignment = .center

        view.addSubview(messageLabel)

        messageLabel.translatesAutoresizingMaskIntoConstraints                                       = false
        messageLabel.heightAnchor.constraint(equalToConstant: 16).isActive                           = true
        messageLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16).isActive    = true
        messageLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16).isActive = true
        messageLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 177).isActive           = true
    }

    // MARK: - EmailTextField
    func setupEmailTextField() {
        emailTextField                       = UITextField()
        emailTextField.backgroundColor       = Colors.inputBGColor
        emailTextField.attributedPlaceholder = NSAttributedString(string: "Email",
                                                                  attributes: [NSAttributedString.Key.foregroundColor: UIColor.black,
                                                                               NSAttributedString.Key.font: UIFont.systemFont(ofSize: Sizes.mediumTextSize, weight: .regular)])
        emailTextField.textColor             = Colors.textColor
        emailTextField.layer.cornerRadius    = Sizes.defaultCornerRadius
        emailTextField.setLeftPaddingPoints(Sizes.textFieldPadding)

        view.addSubview(emailTextField)

        emailTextField.translatesAutoresizingMaskIntoConstraints                                       = false
        emailTextField.heightAnchor.constraint(equalToConstant: 50).isActive                           = true
        emailTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16).isActive    = true
        emailTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16).isActive = true
        emailTextField.topAnchor.constraint(equalTo: view.topAnchor, constant: 217).isActive           = true
    }

    // MARK: - ContinueButton
    func setupContinueButton() {
        continueButton                    = UIButton()
        continueButton.backgroundColor    = Colors.inputBGColor
        continueButton.layer.cornerRadius = Sizes.defaultCornerRadius
        continueButton.titleLabel?.font   = .systemFont(ofSize: Sizes.mediumTextSize, weight: .semibold)
        continueButton.setTitleColor(Colors.textColor, for: .normal)
        continueButton.setTitle("Continue", for: .normal)
        continueButton.addTarget(self, action: #selector(forgotPasswordButtonPressed), for: .touchUpInside)

        view.addSubview(continueButton)

        continueButton.translatesAutoresizingMaskIntoConstraints                                       = false
        continueButton.heightAnchor.constraint(equalToConstant: 56).isActive                           = true
        continueButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16).isActive    = true
        continueButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16).isActive = true
        continueButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -56).isActive     = true
    }
}
