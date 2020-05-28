import Foundation

extension AuthView {

    func setupLogoLabelConstraints() {
        addSubview(logoImageView)

        logoImageView.translatesAutoresizingMaskIntoConstraints                                                       = false
        logoImageView.widthAnchor.constraint(equalToConstant: 150).isActive                                           = true
        logoImageView.heightAnchor.constraint(equalToConstant: 74).isActive                                           = true
        logoImageView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive                                       = true
        logoImageView.topAnchor.constraint(equalTo: topAnchor, constant: 15).isActive                                 = true
    }

    func setupLoginLabelConstraints() {
        addSubview(headLabel)

        headLabel.translatesAutoresizingMaskIntoConstraints                                                           = false
        headLabel.heightAnchor.constraint(equalToConstant: 41).isActive                                               = true
        headLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16).isActive                             = true
        headLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16).isActive                          = true
        headLabel.topAnchor.constraint(equalTo: topAnchor, constant: 151).isActive                                    = true
    }

    func setupMessageLabelConstraints() {
        addSubview(messageLabel)

        messageLabel.translatesAutoresizingMaskIntoConstraints                                                        = false
        messageLabelTopConstraint                                                                                     = messageLabel.topAnchor.constraint(equalTo: topAnchor, constant: 296)
        messageLabelTopConstraint.isActive                                                                            = true

        messageLabel.heightAnchor.constraint(equalToConstant: 16).isActive                                            = true
        messageLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16).isActive                          = true
        messageLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16).isActive                       = true

    }

    func setupGoogleLoginButtonContraints() {
        googleLoginButton.widthAnchor.constraint(equalToConstant: 72).isActive                                        = true
        googleLoginButton.heightAnchor.constraint(equalToConstant: 56).isActive                                       = true
    }

    func setupFbLoginButtonContraints() {
        fbLoginButton.widthAnchor.constraint(equalToConstant: 72).isActive                                            = true
        fbLoginButton.heightAnchor.constraint(equalToConstant: 56).isActive                                           = true
    }

    func setupCustomLoginButtonsStackViewConstraints() {
        addSubview(customLoginButtonsStackView)

        customLoginButtonsStackView.translatesAutoresizingMaskIntoConstraints                                         = false
        customLoginButtonsStackView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive                         = true
        customLoginButtonsStackView.topAnchor.constraint(equalTo: topAnchor, constant: 216).isActive                  = true
    }

    func setupForgotButtonConstraints() {
        addSubview(forgotPasswordButton)

        forgotPasswordButton.translatesAutoresizingMaskIntoConstraints                                                = false
        forgotPasswordButton.widthAnchor.constraint(equalToConstant: 160).isActive                                    = true
        forgotPasswordButton.heightAnchor.constraint(equalToConstant: 16).isActive                                    = true
        forgotPasswordButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -32).isActive               = true
        forgotPasswordButton.centerYAnchor.constraint(equalTo: passwordTextField.centerYAnchor, constant: 0).isActive = true
    }

    func setupSignUpButtonConstraints() {
        addSubview(signUpButton)

        signUpButton.translatesAutoresizingMaskIntoConstraints                                                        = false
        signUpButton.heightAnchor.constraint(equalToConstant: 16).isActive                                            = true
        signUpButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 39).isActive                          = true
        signUpButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -39).isActive                       = true
        signUpButton.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 36).isActive             = true
    }

    func setupActivityIndicatorConstraints() {
        addSubview(activityIndicator)

        activityIndicator.translatesAutoresizingMaskIntoConstraints                                                   = false
        activityIndicator.centerXAnchor.constraint(equalTo: centerXAnchor).isActive                                   = true
        activityIndicator.bottomAnchor.constraint(equalTo: nextButton.bottomAnchor, constant: -18).isActive           = true
    }

    func setupErrorLabelConstraints() {
        addSubview(errorLabel)

        errorLabel.translatesAutoresizingMaskIntoConstraints                                                          = false
        errorLabel.heightAnchor.constraint(equalToConstant: 40).isActive                                              = true
        errorLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 39).isActive                            = true
        errorLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -39).isActive                         = true
        errorLabel.bottomAnchor.constraint(equalTo: nextButton.topAnchor, constant: -15).isActive                     = true
    }
}
