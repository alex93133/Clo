import UIKit

class CustomAlertController: UIAlertController {
    
    // MARK: - Properties
    var symbol: Symbol!
    var symbolDescriptionLabel: UILabel!
    var symbolImage: UIImageView!
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        addActions()
        setupSymbolImage()
        setupSymbolDescriptionLabel()
    }
    
    // MARK: - View
    private func setupView() {
        view.tintColor                                              = Colors.mintColor
        view.translatesAutoresizingMaskIntoConstraints              = false
        view.heightAnchor.constraint(equalToConstant: 220).isActive = true
        overrideUserInterfaceStyle                                  = .light
    }
    
    private func addActions() {
        let cancelAction = UIAlertAction(title: "Ok", style: .cancel)
        addAction(cancelAction)
    }
    
    // MARK: - SymbolImage
    private func setupSymbolImage() {
        symbolImage             = UIImageView()
        symbolImage.image       = symbol.image
        symbolImage.contentMode = .scaleAspectFill
        setupSymbolImageConstraints()
    }
    
    // MARK: - SymbolDescription
    private func setupSymbolDescriptionLabel() {
        symbolDescriptionLabel               = UILabel()
        symbolDescriptionLabel.font          = .systemFont(ofSize: Constants.Fonts.mediumTextSize, weight: .semibold)
        symbolDescriptionLabel.textColor     = Colors.blackTextColor
        symbolDescriptionLabel.textAlignment = .center
        symbolDescriptionLabel.numberOfLines = 0
        symbolDescriptionLabel.text          = symbol.description
        setupSymbolDescriptionLabelConstraints()
    }
}

// MARK: - Constraints
extension CustomAlertController {
    
    private func setupSymbolImageConstraints() {
        view.addSubview(symbolImage)
        
        symbolImage.translatesAutoresizingMaskIntoConstraints                            = false
        symbolImage.heightAnchor.constraint(equalToConstant: 70).isActive                = true
        symbolImage.widthAnchor.constraint(equalToConstant: 70).isActive                 = true
        symbolImage.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive       = true
        symbolImage.topAnchor.constraint(equalTo: view.topAnchor, constant: 25).isActive = true
    }
    
    private func setupSymbolDescriptionLabelConstraints() {
        view.addSubview(symbolDescriptionLabel)
        
        symbolDescriptionLabel.translatesAutoresizingMaskIntoConstraints                                       = false
        symbolDescriptionLabel.heightAnchor.constraint(equalToConstant: 24).isActive                           = true
        symbolDescriptionLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16).isActive    = true
        symbolDescriptionLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16).isActive = true
        symbolDescriptionLabel.topAnchor.constraint(equalTo: symbolImage.bottomAnchor, constant: 16).isActive  = true
    }
}

