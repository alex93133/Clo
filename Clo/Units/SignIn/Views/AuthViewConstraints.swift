import Foundation

extension AuthView {

    func setupLogoLabelConstraints() {
        addSubview(logoLabel)

        logoLabel.translatesAutoresizingMaskIntoConstraints                                                 = false
        logoLabel.widthAnchor.constraint(equalToConstant: 150).isActive                                     = true
        logoLabel.heightAnchor.constraint(equalToConstant: 74).isActive                                     = true
        logoLabel.centerXAnchor.constraint(equalTo: centerXAnchor).isActive                                 = true
        logoLabel.topAnchor.constraint(equalTo: topAnchor, constant: 80).isActive                           = true
    }

    func setupLoginLabelConstraints() {
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

    func setupGoogleLoginButtonContraints() {
        googleLoginButton.widthAnchor.constraint(equalToConstant: 72).isActive                              = true
        googleLoginButton.heightAnchor.constraint(equalToConstant: 56).isActive                             = true
    }

    func setupFbLoginButtonContraints() {
        fbLoginButton.widthAnchor.constraint(equalToConstant: 72).isActive                                  = true
        fbLoginButton.heightAnchor.constraint(equalToConstant: 56).isActive                                 = true
    }

    func setupCustomLoginButtonsStackViewConstraints() {
        addSubview(customLoginButtonsStackView)

        customLoginButtonsStackView.translatesAutoresizingMaskIntoConstraints                               = false
        customLoginButtonsStackView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive               = true
        customLoginButtonsStackView.topAnchor.constraint(equalTo: topAnchor, constant: 236).isActive        = true
    }

    func setupEmailTextFieldConstraints() {
        addSubview(emailTextField)

        emailTextField.translatesAutoresizingMaskIntoConstraints                                            = false
        emailTextField.heightAnchor.constraint(equalToConstant: 50).isActive                                = true
        emailTextField.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16).isActive              = true
        emailTextField.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16).isActive           = true
        emailTextField.topAnchor.constraint(equalTo: topAnchor, constant: 356).isActive                     = true
    }

    func setupPasswordTextFieldConstraints() {
        addSubview(passwordTextField)

        passwordTextField.translatesAutoresizingMaskIntoConstraints                                         = false
        passwordTextField.heightAnchor.constraint(equalToConstant: 50).isActive                             = true
        passwordTextField.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16).isActive           = true
        passwordTextField.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16).isActive        = true
        passwordTextField.topAnchor.constraint(equalTo: topAnchor, constant: 414).isActive                  = true
    }

    func setupReEnterPasswordConstraints() {
        addSubview(reEnterPasswordTextField)

        reEnterPasswordTextField.translatesAutoresizingMaskIntoConstraints                                  = false
        reEnterPasswordTextField.heightAnchor.constraint(equalToConstant: 50).isActive                      = true
        reEnterPasswordTextField.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16).isActive    = true
        reEnterPasswordTextField.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16).isActive = true
        reEnterPasswordTextField.topAnchor.constraint(equalTo: topAnchor, constant: 472).isActive           = true
    }

    func setupForgotButtonConstraints() {
        addSubview(forgotPasswordButton)

        forgotPasswordButton.translatesAutoresizingMaskIntoConstraints                                      = false
        forgotPasswordButton.widthAnchor.constraint(equalToConstant: 179).isActive                          = true
        forgotPasswordButton.heightAnchor.constraint(equalToConstant: 16).isActive                          = true
        forgotPasswordButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -32).isActive     = true
        forgotPasswordButton.topAnchor.constraint(equalTo: topAnchor, constant: 430).isActive               = true
    }

    func setupSignUpButtonConstraints() {
        addSubview(signUpButton)

        signUpButton.translatesAutoresizingMaskIntoConstraints                                              = false
        signUpButton.heightAnchor.constraint(equalToConstant: 16).isActive                                  = true
        signUpButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 39).isActive                = true
        signUpButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -39).isActive             = true
        signUpButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -56).isActive                 = true
    }

    func setupNextButtonConstraints() {
        addSubview(nextButton)

        nextButton.translatesAutoresizingMaskIntoConstraints                                                = false
        nextButton.heightAnchor.constraint(equalToConstant: 56).isActive                                    = true
        nextButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16).isActive                  = true
        nextButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16).isActive               = true
        nextButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -104).isActive                  = true
    }

    func setupActivityIndicatorConstraints() {
        addSubview(activityIndicator)

        activityIndicator.translatesAutoresizingMaskIntoConstraints                                         = false
        activityIndicator.centerXAnchor.constraint(equalTo: centerXAnchor).isActive                         = true
        activityIndicator.bottomAnchor.constraint(equalTo: nextButton.bottomAnchor, constant: -18).isActive = true
    }

    func setupErrorLabelConstraints() {
        addSubview(errorLabel)

        errorLabel.translatesAutoresizingMaskIntoConstraints                                                = false
        errorLabel.heightAnchor.constraint(equalToConstant: 40).isActive                                    = true
        errorLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 39).isActive                  = true
        errorLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -39).isActive               = true
        errorLabel.bottomAnchor.constraint(equalTo: nextButton.topAnchor, constant: -30).isActive           = true
    }
}
