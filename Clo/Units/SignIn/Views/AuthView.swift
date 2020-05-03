import UIKit
import GoogleSignIn
import AuthenticationServices
import FacebookLogin

// MARK: - Delegates
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
    var buttonHandler: (() -> (Void))?
    
    var logoLabel: UILabel!
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
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setLogoLabel()
        setupLoginLabel()
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
        
        backgroundColor = Colors.viewBGColor
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    // MARK: - Create TextField
    static func createTextField(placeholder: String) -> UITextField {
        let textField                    = UITextField()
        textField.backgroundColor        = Colors.inputBGColor
        textField.attributedPlaceholder  = NSAttributedString(string: placeholder,
                                                              attributes: [NSAttributedString.Key.foregroundColor: UIColor.black,
                                                                           NSAttributedString.Key.font: UIFont.systemFont(ofSize: Sizes.mediumTextSize, weight: .regular)])
        textField.textColor              = Colors.textColor
        textField.layer.cornerRadius     = Sizes.defaultCornerRadius
        textField.autocapitalizationType = .none
        textField.setLeftPaddingPoints(Sizes.textFieldPadding)
        return textField
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
    private func setLogoLabel() {
        logoLabel               = UILabel()
        logoLabel.text          = "Clo"
        logoLabel.textAlignment = .center
        logoLabel.isHidden      = true
        setupLogoLabelConstraints()
    }
    
    // MARK: - LoginLabel
    private func setupLoginLabel() {
        headLabel               = UILabel()
        headLabel.text          = "Login"
        headLabel.font          = .systemFont(ofSize: Sizes.headTextSize, weight: .bold)
        headLabel.textColor     = Colors.textColor
        headLabel.textAlignment = .center
        setupLoginLabelConstraints()
    }
    
    // MARK: - MessageLabel
    private func setupMessageLabel() {
        messageLabel               = UILabel()
        messageLabel.text          = "or login with email"
        messageLabel.font          = .systemFont(ofSize: Sizes.smallTextSize, weight: .regular)
        messageLabel.textColor     = Colors.textColor
        messageLabel.textAlignment = .center
        setupMessageLabelConstraints()
    }
    
    // MARK: - EmailTextField
    private func setupEmailTextField() {
        emailTextField                 = AuthView.createTextField(placeholder: "Email")
        emailTextField.textContentType = .emailAddress
        setupEmailTextFieldConstraints()
    }
    
    // MARK: - PasswordTextField
    private func setupPasswordTextField() {
        passwordTextField                       = AuthView.createTextField(placeholder: "Password")
        passwordTextField.isSecureTextEntry     = true
        passwordTextField.setLeftPaddingPoints(Sizes.textFieldPadding)
        setupPasswordTextFieldConstraints()
    }
    
    // MARK: - ReEnterPasswordTextField
    private func setupReEnterPassword() {
        reEnterPasswordTextField                       = AuthView.createTextField(placeholder: "Re-enter password")
        reEnterPasswordTextField.isSecureTextEntry     = true
        reEnterPasswordTextField.setLeftPaddingPoints(Sizes.textFieldPadding)
        setupReEnterPasswordConstraints()
    }
    
    // MARK: - ForgotButton
    private func setupForgotButton() {
        forgotPasswordButton                            = UIButton()
        forgotPasswordButton.titleLabel?.font           = .systemFont(ofSize: Sizes.smallTextSize, weight: .regular)
        forgotPasswordButton.contentHorizontalAlignment = .right
        forgotPasswordButton.setTitleColor(Colors.textColor, for: .normal)
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
        googleLoginButton                                                       = UIButton()
        googleLoginButton.backgroundColor                                       = .white
        googleLoginButton.imageView?.contentMode                                = .scaleAspectFit
        googleLoginButton.contentEdgeInsets                                     = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        googleLoginButton.layer.cornerRadius                                    = Sizes.customLoginButtonCornerRadius
        googleLoginButton.setImage(Images.googleIcon, for: .normal)
        googleLoginButton.addTarget(self, action: #selector(signInWithGoogleButtonPressed), for: .touchUpInside)
        setupGoogleLoginButtonContraints()
    }
    
    // MARK: - FbLoginButton
    private func setupFbLoginButton() {
        fbLoginButton                                                       = UIButton()
        fbLoginButton.backgroundColor                                       = .white
        fbLoginButton.imageView?.contentMode                                = .scaleAspectFit
        fbLoginButton.contentEdgeInsets                                     = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        fbLoginButton.layer.cornerRadius                                    = Sizes.customLoginButtonCornerRadius
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
        
        customViewForAppleButton.layer.cornerRadius = Sizes.customLoginButtonCornerRadius
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
        errorLabel.font          = .systemFont(ofSize: Sizes.smallTextSize, weight: .regular)
        errorLabel.textColor     = Colors.errorTextColor
        errorLabel.textAlignment = .center
        errorLabel.alpha         = 0
        errorLabel.numberOfLines = 0
        setupErrorLabelConstraints()
    }
    
    // MARK: - NextButton
    private func setupNextButton() {
        nextButton                    = UIButton()
        nextButton.backgroundColor    = Colors.inputBGColor
        nextButton.layer.cornerRadius = Sizes.defaultCornerRadius
        nextButton.titleLabel?.font   = .systemFont(ofSize: Sizes.mediumTextSize, weight: .semibold)
        nextButton.setTitleColor(Colors.textColor, for: .normal)
        nextButton.setTitle("Sign in", for: .normal)
        nextButton.addTarget(self, action: #selector(nextButtonPressed), for: .touchUpInside)
        setupNextButtonConstraints()
    }
    
    
    // MARK: - SignUpButton
    private func setupSignUpButton() {
        signUpButton                  = UIButton()
        signUpButton.titleLabel?.font = .systemFont(ofSize: Sizes.smallTextSize, weight: .regular)
        signUpButton.setTitle("Don’t have an account? Create account", for: .normal)
        signUpButton.setTitleColor(Colors.textColor, for: .normal)
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
