import Foundation

// MARK: - Constraints
extension ForgotPasswordView {

    func setupHeadLabelConstraints() {
        addSubview(headLabel)

        headLabel.translatesAutoresizingMaskIntoConstraints                                                 = false
        headLabel.heightAnchor.constraint(equalToConstant: 41).isActive                                     = true
        headLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16).isActive                   = true
        headLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16).isActive                = true
        headLabel.topAnchor.constraint(equalTo: topAnchor, constant: 171).isActive                          = true
    }

    func setupMessageLabelConstraints() {
        addSubview(messageLabel)

        messageLabel.translatesAutoresizingMaskIntoConstraints                                              = false
        messageLabel.heightAnchor.constraint(equalToConstant: 16).isActive                                  = true
        messageLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16).isActive                = true
        messageLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16).isActive             = true
        messageLabel.topAnchor.constraint(equalTo: topAnchor, constant: 316).isActive                       = true
    }

    func setupEmailTextFieldConstraints() {
        addSubview(emailTextField)

        emailTextField.translatesAutoresizingMaskIntoConstraints                                            = false
        emailTextField.heightAnchor.constraint(equalToConstant: 50).isActive                                = true
        emailTextField.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16).isActive              = true
        emailTextField.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16).isActive           = true
        emailTextField.topAnchor.constraint(equalTo: topAnchor, constant: 356).isActive                     = true
    }

    func setupNextButtonConstraints() {
        addSubview(forgotButton)

        forgotButton.translatesAutoresizingMaskIntoConstraints                                                 = false
        forgotButton.heightAnchor.constraint(equalToConstant: 56).isActive                                     = true
        forgotButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16).isActive                   = true
        forgotButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16).isActive                = true
        forgotButton.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -8).isActive = true
    }

}
