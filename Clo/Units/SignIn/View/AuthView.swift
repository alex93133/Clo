import UIKit
import GoogleSignIn
import AuthenticationServices
import FacebookLogin

// MARK: - Delegate
protocol AuthViewDelegate: class {
    func handleLogInWithAppleID()
    func signInWithGoogleButtonPressed()
    func signInWithFacebookButtonPressed()
    func signInWithEmailButtonPressed()
    func forgotPasswordButtonPressed()
    func signUpButtonPressed()
}

class AuthView: UIView {

    // MARK: - Properties
    weak var delegate: AuthViewDelegate?
    var buttonHandler: (() -> Void)?

    var logoImageView: UIImageView!
    var headLabel: UILabel!
    var messageLabel: UILabel!
    var emailTextField: UITextField!
    var passwordTextField: UITextField!
    var reEnterPasswordTextField: UITextField!
    var appleLoginButton: ASAuthorizationAppleIDButton!
    var googleLoginButton: UIButton!
    var fbLoginButton: UIButton!
    var customLoginButtonsStackView: UIStackView!
    var forgotPasswordButton: UIButton!
    var nextButton: UIButton!
    var errorLabel: UILabel!
    var signUpButton: UIButton!
    var activityIndicator: UIActivityIndicatorView!

    var messageLabelTopConstraint: NSLayoutConstraint!

    override init(frame: CGRect) {
        super.init(frame: frame)
        setLogoImageView()
        setupHeadLabel()
        setupMessageLabel()
        setupCustomLoginButtonsStackView()
        setupEmailTextField()
        setupPasswordTextField()
        setupReEnterPassword()
        setupForgotButton()
        setupSignUpButton()
        setupNextButton()
        setupActivityIndicator()
        setupErrorLabel()

        backgroundColor = Colors.lightGrayBGColor
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    // MARK: - DisplayError
    func displayError(errorText: String) {
        UIView.animate(withDuration: Constants.animationTimeInterval) { [unowned self] in
            self.errorLabel.text  = errorText
            self.errorLabel.alpha = 1
        }
    }

    // MARK: - Processing
    func processing(isProcessing: Bool) {
        UIView.animate(withDuration: Constants.animationTimeInterval) { [unowned self] in
            self.nextButton.isEnabled = !isProcessing
            if isProcessing {
                self.activityIndicator.startAnimating()
                self.nextButton.alpha = 0.2
            } else {
                self.activityIndicator.stopAnimating()
                self.nextButton.alpha = 1
            }
        }
    }

    // MARK: - LogoLabel
    private func setLogoImageView() {
        logoImageView       = UIImageView()
        logoImageView.image = Images.logoImage
        logoImageView.contentMode = .scaleAspectFit
        setupLogoLabelConstraints()
    }

    // MARK: - LoginLabel
    private func setupHeadLabel() {
        headLabel               = UILabel()
        headLabel.text          = "Login"
        headLabel.font          = .systemFont(ofSize: Constants.Fonts.headTextSize, weight: .heavy)
        headLabel.textColor     = Colors.blackTextColor
        headLabel.textAlignment = .center
        setupLoginLabelConstraints()
    }

    // MARK: - MessageLabel
    private func setupMessageLabel() {
        messageLabel               = UILabel()
        messageLabel.text          = "or login with email"
        messageLabel.font          = .systemFont(ofSize: Constants.Fonts.smallTextSize, weight: .regular)
        messageLabel.textColor     = Colors.grayTextColor
        messageLabel.textAlignment = .center
        setupMessageLabelConstraints()
    }

    // MARK: - EmailTextField
    private func setupEmailTextField() {
        emailTextField                 = CustomTextField(placeholder: "Email", addTo: self)
        emailTextField.textContentType = .emailAddress
        emailTextField.topAnchor.constraint(equalTo: messageLabel.bottomAnchor, constant: 44).isActive = true
    }

    // MARK: - PasswordTextField
    private func setupPasswordTextField() {
        passwordTextField                       = CustomTextField(placeholder: "Password", addTo: self)
        passwordTextField.isSecureTextEntry     = true
        passwordTextField.setLeftPaddingPoints(Constants.textFieldPadding)
        passwordTextField.topAnchor.constraint(equalTo: emailTextField.bottomAnchor, constant: 24).isActive = true
    }

    // MARK: - ReEnterPasswordTextField
    private func setupReEnterPassword() {
        reEnterPasswordTextField                       = CustomTextField(placeholder: "Re-enter password", addTo: self)
        reEnterPasswordTextField.isSecureTextEntry     = true
        reEnterPasswordTextField.setLeftPaddingPoints(Constants.textFieldPadding)
        reEnterPasswordTextField.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 24).isActive = true
    }

    // MARK: - ForgotButton
    private func setupForgotButton() {
        forgotPasswordButton                            = UIButton()
        forgotPasswordButton.titleLabel?.font           = .systemFont(ofSize: Constants.Fonts.smallTextSize, weight: .semibold)
        forgotPasswordButton.contentHorizontalAlignment = .right
        forgotPasswordButton.setTitleColor(Colors.grayTextColor, for: .normal)
        forgotPasswordButton.setTitle("Forgot password?", for: .normal)
        forgotPasswordButton.addTarget(self, action: #selector(forgotPasswordButtonPressed), for: .touchUpInside)
        setupForgotButtonConstraints()
    }

    // MARK: - AppleLogInButton
    private func setupAppleLogInButton() {
        appleLoginButton       = ASAuthorizationAppleIDButton(authorizationButtonType: .signIn, authorizationButtonStyle: .white)
        appleLoginButton.frame = CGRect(x: 0, y: 0, width: 100, height: 100)
        appleLoginButton.addTarget(self, action: #selector(handleLogInWithAppleID), for: .touchUpInside)
    }

    // MARK: - GoogleLoginButton
    private func setupGoogleLoginButton() {
        googleLoginButton                        = UIButton()
        googleLoginButton.backgroundColor        = .white
        googleLoginButton.imageView?.contentMode = .scaleAspectFit
        googleLoginButton.contentEdgeInsets      = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        googleLoginButton.layer.cornerRadius     = Constants.customLoginButtonCornerRadius
        googleLoginButton.layer.borderWidth      = 1
        googleLoginButton.layer.borderColor      = Colors.separator
        googleLoginButton.setImage(Images.googleIcon, for: .normal)
        googleLoginButton.addTarget(self, action: #selector(signInWithGoogleButtonPressed), for: .touchUpInside)
        setupGoogleLoginButtonContraints()
    }

    // MARK: - FbLoginButton
    private func setupFbLoginButton() {
        fbLoginButton                        = UIButton()
        fbLoginButton.backgroundColor        = .white
        fbLoginButton.imageView?.contentMode = .scaleAspectFit
        fbLoginButton.contentEdgeInsets      = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        fbLoginButton.layer.cornerRadius     = Constants.customLoginButtonCornerRadius
        fbLoginButton.layer.borderWidth      = 1
        fbLoginButton.layer.borderColor      = Colors.separator
        fbLoginButton.setImage(Images.facebookIcon, for: .normal)
        fbLoginButton.addTarget(self, action: #selector(signInWithFacebookButtonPressed), for: .touchUpInside)
        setupFbLoginButtonContraints()
    }

    // MARK: - CustomLoginButtonsStackView
    private func setupCustomLoginButtonsStackView() {
        setupAppleLogInButton()
        setupGoogleLoginButton()
        setupFbLoginButton()

        let customViewForAppleButton = UIView(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
        customViewForAppleButton.widthAnchor.constraint(equalToConstant: 72).isActive = true
        customViewForAppleButton.heightAnchor.constraint(equalToConstant: 56).isActive = true
        appleLoginButton.center = CGPoint(x: 72 / 2,
                                          y: 56 / 2)

        customViewForAppleButton.layer.cornerRadius = Constants.customLoginButtonCornerRadius
        customViewForAppleButton.layer.borderWidth  = 1
        customViewForAppleButton.layer.borderColor  = Colors.separator
        customViewForAppleButton.addSubview(appleLoginButton)
        customViewForAppleButton.clipsToBounds      = true

        customLoginButtonsStackView              = UIStackView(arrangedSubviews: [customViewForAppleButton, googleLoginButton, fbLoginButton])
        customLoginButtonsStackView.axis         = .horizontal
        customLoginButtonsStackView.distribution = .equalSpacing
        customLoginButtonsStackView.alignment    = .center
        customLoginButtonsStackView.spacing      = 30
        setupCustomLoginButtonsStackViewConstraints()
    }

    // MARK: - ErrorLabel
    private func setupErrorLabel() {
        errorLabel               = UILabel()
        errorLabel.font          = .systemFont(ofSize: Constants.Fonts.smallTextSize, weight: .regular)
        errorLabel.textColor     = Colors.errorTextColor
        errorLabel.textAlignment = .center
        errorLabel.alpha         = 0
        errorLabel.numberOfLines = 0
        setupErrorLabelConstraints()
    }

    // MARK: - NextButton
    private func setupNextButton() {
        nextButton = NextButton(title: "Sign in", action: #selector(nextButtonPressed), addTo: self)
    }

    // MARK: - SignUpButton
    private func setupSignUpButton() {
        signUpButton                  = UIButton()
        signUpButton.titleLabel?.font = .systemFont(ofSize: Constants.Fonts.smallTextSize, weight: .regular)

        let firstPart = "Don’t have an account? "
        let secondPart = "Create account"

        let attributedStr1 = NSMutableAttributedString(string: firstPart)
        attributedStr1.addAttribute(NSAttributedString.Key.font,
                                    value: UIFont.systemFont(ofSize: Constants.Fonts.smallTextSize, weight: .regular),
                                    range: NSRange(location: 0, length: attributedStr1.length))
        attributedStr1.addAttribute(NSAttributedString.Key.foregroundColor,
                                    value: Colors.grayTextColor,
                                    range: NSRange(location: 0, length: attributedStr1.length))

        let attributedStr2 = NSMutableAttributedString(string: secondPart)
        attributedStr2.addAttribute(NSAttributedString.Key.font,
                                    value: UIFont.systemFont(ofSize: Constants.Fonts.smallTextSize, weight: .regular),
                                    range: NSRange(location: 0, length: attributedStr2.length))
        attributedStr2.addAttribute(NSAttributedString.Key.foregroundColor,
                                    value: Colors.mintColor,
                                    range: NSRange(location: 0, length: attributedStr2.length))

        let attributedText = NSMutableAttributedString()
        attributedText.append(attributedStr1)
        attributedText.append(attributedStr2)

        signUpButton.setTitleColor(Colors.grayTextColor, for: .normal)
        signUpButton.setAttributedTitle(attributedText, for: .normal)

        signUpButton.addTarget(self, action: #selector(signUpButtonPressed), for: .touchUpInside)
        setupSignUpButtonConstraints()
    }

    // MARK: - ActivityIndicator
    private func setupActivityIndicator() {
        activityIndicator                  = UIActivityIndicatorView()
        activityIndicator.hidesWhenStopped = true
        activityIndicator.color            = Colors.activityIndicatorColor
        setupActivityIndicatorConstraints()
    }
}

// MARK: - Actions
extension AuthView {

    @objc func handleLogInWithAppleID() {
        delegate?.handleLogInWithAppleID()
    }

    @objc func signInWithGoogleButtonPressed() {
        delegate?.signInWithGoogleButtonPressed()
    }

    @objc func signInWithFacebookButtonPressed() {
        delegate?.signInWithFacebookButtonPressed()
    }

    @objc func nextButtonPressed() {
        buttonHandler?()
    }

    @objc func forgotPasswordButtonPressed() {
        delegate?.forgotPasswordButtonPressed()
    }

    @objc func signUpButtonPressed() {
        delegate?.signUpButtonPressed()
    }
}
