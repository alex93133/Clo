import UIKit
import GoogleSignIn
import AuthenticationServices
import FacebookLogin

extension SignInViewController {
    func setup() {
        GIDSignIn.sharedInstance().delegate                  = self
        GIDSignIn.sharedInstance()?.presentingViewController = self

        setLogoLabel()
        setupLoginLabel()
        setupLoginWithEmailLabel()
        setupEmailTextField()

        setupCustomLoginButtonsStackView()

        setupPasswordTextField()
        setupSignInButton()
        setupForgotButton()
        setupSignUpButton()
        setupActivityIndicator()

        view.backgroundColor = Colors.viewBGColor

    }

    // MARK: - LogoLabel
    func setLogoLabel() {
        logoLabel                 = UILabel()
        logoLabel.text            = "Clo"
        logoLabel.backgroundColor = .gray
        logoLabel.textAlignment   = .center

        view.addSubview(logoLabel)

        logoLabel.translatesAutoresizingMaskIntoConstraints = false
        logoLabel.widthAnchor.constraint(equalToConstant: 150).isActive = true
        logoLabel.heightAnchor.constraint(equalToConstant: 74).isActive = true
        logoLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        logoLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 80).isActive = true

    }

    // MARK: - LoginLabel
    func setupLoginLabel() {
        loginLabel               = UILabel()
        loginLabel.text          = "Login"
        loginLabel.font          = .systemFont(ofSize: Sizes.headTextSize, weight: .bold)
        loginLabel.textColor     = Colors.textColor
        loginLabel.textAlignment = .center

        view.addSubview(loginLabel)

        loginLabel.translatesAutoresizingMaskIntoConstraints                                       = false
        loginLabel.heightAnchor.constraint(equalToConstant: 41).isActive                           = true
        loginLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16).isActive    = true
        loginLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16).isActive = true
        loginLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 171).isActive           = true
    }

    // MARK: - LoginWithEmailLabel
    func setupLoginWithEmailLabel() {
        messageLabel               = UILabel()
        messageLabel.text          = "or login with email"
        messageLabel.font          = .systemFont(ofSize: Sizes.smallTextSize, weight: .regular)
        messageLabel.textColor     = Colors.textColor
        messageLabel.textAlignment = .center

        view.addSubview(messageLabel)

        messageLabel.translatesAutoresizingMaskIntoConstraints                                       = false
        messageLabel.heightAnchor.constraint(equalToConstant: 16).isActive                           = true
        messageLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 98).isActive    = true
        messageLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -98).isActive = true
        messageLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 316).isActive           = true
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
        emailTextField.topAnchor.constraint(equalTo: view.topAnchor, constant: 356).isActive           = true

    }

    // MARK: - PasswordTextField
    func setupPasswordTextField() {
        passwordTextField                       = UITextField()
        passwordTextField.backgroundColor       = Colors.inputBGColor
        passwordTextField.attributedPlaceholder = NSAttributedString(string: "Password",
                                                                     attributes: [NSAttributedString.Key.foregroundColor: UIColor.black,
                                                                                  NSAttributedString.Key.font: UIFont.systemFont(ofSize: Sizes.mediumTextSize, weight: .regular)])
        passwordTextField.textColor             = Colors.textColor
        passwordTextField.layer.cornerRadius    = Sizes.defaultCornerRadius
        passwordTextField.isSecureTextEntry     = true
        passwordTextField.setLeftPaddingPoints(Sizes.textFieldPadding)

        view.addSubview(passwordTextField)

        passwordTextField.translatesAutoresizingMaskIntoConstraints                                       = false
        passwordTextField.heightAnchor.constraint(equalToConstant: 50).isActive                           = true
        passwordTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16).isActive    = true
        passwordTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16).isActive = true
        passwordTextField.topAnchor.constraint(equalTo: view.topAnchor, constant: 414).isActive           = true

    }

    // MARK: - AppleLogInButton
    func setupAppleLogInButton() {
        appleLoginButton       = ASAuthorizationAppleIDButton(authorizationButtonType: .signIn, authorizationButtonStyle: .white)
        appleLoginButton.frame = CGRect(x: 0, y: 0, width: 100, height: 100)
        appleLoginButton.addTarget(self, action: #selector(handleLogInWithAppleID), for: .touchUpInside)
    }

    // MARK: - GoogleLoginButton
    func setupGoogleLoginButton() {
        googleLoginButton                                                       = UIButton()
        googleLoginButton.widthAnchor.constraint(equalToConstant: 72).isActive  = true
        googleLoginButton.heightAnchor.constraint(equalToConstant: 56).isActive = true
        googleLoginButton.backgroundColor                                       = .white
        googleLoginButton.imageView?.contentMode                                = .scaleAspectFit
        googleLoginButton.contentEdgeInsets                                     = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        googleLoginButton.layer.cornerRadius                                    = Sizes.customLoginButtonCornerRadius
        googleLoginButton.setImage(Images.googleIcon, for: .normal)
        googleLoginButton.addTarget(self, action: #selector(signInWithGoogleButtonPressed), for: .touchUpInside)
    }

    // MARK: - FbLoginButton
    func setupFbLoginButton() {
        fbLoginButton                                                       = UIButton()
        fbLoginButton.widthAnchor.constraint(equalToConstant: 72).isActive  = true
        fbLoginButton.heightAnchor.constraint(equalToConstant: 56).isActive = true
        fbLoginButton.backgroundColor                                       = .white
        fbLoginButton.imageView?.contentMode                                = .scaleAspectFit
        fbLoginButton.contentEdgeInsets                                     = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        fbLoginButton.layer.cornerRadius                                    = Sizes.customLoginButtonCornerRadius
        fbLoginButton.setImage(Images.facebookIcon, for: .normal)
        fbLoginButton.addTarget(self, action: #selector(signInWithFacebookButtonPressed), for: .touchUpInside)
    }

    // MARK: - CustomLoginButtonsStackView
    func setupCustomLoginButtonsStackView() {
        setupAppleLogInButton()
        setupGoogleLoginButton()
        setupFbLoginButton()

        let customViewForAppleButton = UIView(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
        customViewForAppleButton.widthAnchor.constraint(equalToConstant: 72).isActive = true
        customViewForAppleButton.heightAnchor.constraint(equalToConstant: 56).isActive = true
        appleLoginButton.center = CGPoint(x: 72 / 2,
                                          y: 56 / 2)

        customViewForAppleButton.layer.cornerRadius = Sizes.customLoginButtonCornerRadius
        customViewForAppleButton.addSubview(appleLoginButton)
        customViewForAppleButton.clipsToBounds      = true

        let stackView          = UIStackView(arrangedSubviews: [customViewForAppleButton, googleLoginButton, fbLoginButton])
        stackView.axis         = .horizontal
        stackView.distribution = .equalSpacing
        stackView.alignment    = .center
        stackView.spacing      = 30

        view.addSubview(stackView)

        stackView.translatesAutoresizingMaskIntoConstraints                             = false
        stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive        = true
        stackView.topAnchor.constraint(equalTo: view.topAnchor, constant: 236).isActive = true
    }

    // MARK: - SignInButton
    func setupSignInButton() {
        signInButton                    = UIButton()
        signInButton.backgroundColor    = Colors.inputBGColor
        signInButton.layer.cornerRadius = Sizes.defaultCornerRadius
        signInButton.titleLabel?.font   = .systemFont(ofSize: Sizes.mediumTextSize, weight: .semibold)
        signInButton.setTitleColor(Colors.textColor, for: .normal)
        signInButton.setTitle("Sign in", for: .normal)
        signInButton.addTarget(self, action: #selector(signInWithEmailButtonPressed), for: .touchUpInside)

        view.addSubview(signInButton)

        signInButton.translatesAutoresizingMaskIntoConstraints                                       = false
        signInButton.heightAnchor.constraint(equalToConstant: 56).isActive                           = true
        signInButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16).isActive    = true
        signInButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16).isActive = true
        signInButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -104).isActive    = true
    }

    // MARK: - ForgotButton
    func setupForgotButton() {
        forgotPasswordButton                            = UIButton()
        forgotPasswordButton.titleLabel?.font           = .systemFont(ofSize: Sizes.smallTextSize, weight: .regular)
        forgotPasswordButton.contentHorizontalAlignment = .right
        forgotPasswordButton.setTitleColor(Colors.textColor, for: .normal)
        forgotPasswordButton.setTitle("Forgot password?", for: .normal)
        forgotPasswordButton.addTarget(self, action: #selector(forgotPasswordButtonPressed), for: .touchUpInside)

        view.addSubview(forgotPasswordButton)

        forgotPasswordButton.translatesAutoresizingMaskIntoConstraints                                       = false
        forgotPasswordButton.widthAnchor.constraint(equalToConstant: 179).isActive                           = true
        forgotPasswordButton.heightAnchor.constraint(equalToConstant: 16).isActive                           = true
        forgotPasswordButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -32).isActive = true
        forgotPasswordButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 430).isActive           = true
    }

    // MARK: - SignUpButton
    func setupSignUpButton() {
        signUpButton                  = UIButton()
        signUpButton.titleLabel?.font = .systemFont(ofSize: Sizes.smallTextSize, weight: .regular)
        signUpButton.setTitle("Don’t have an account? Create account", for: .normal)
        signUpButton.setTitleColor(Colors.textColor, for: .normal)
        signUpButton.addTarget(self, action: #selector(signUp), for: .touchUpInside)

        view.addSubview(signUpButton)

        signUpButton.translatesAutoresizingMaskIntoConstraints                                       = false
        signUpButton.heightAnchor.constraint(equalToConstant: 16).isActive                           = true
        signUpButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 39).isActive    = true
        signUpButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -39).isActive = true
        signUpButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -56).isActive     = true
    }

     // MARK: - ActivityIndicator
    func setupActivityIndicator() {
        activityIndicator                  = UIActivityIndicatorView()
        activityIndicator.style            = .large
        activityIndicator.center           = CGPoint(x: signInButton.frame.width / 2,
                                                     y: signInButton.frame.height / 2)
        activityIndicator.hidesWhenStopped = true

        view.addSubview(activityIndicator)
    }
}
