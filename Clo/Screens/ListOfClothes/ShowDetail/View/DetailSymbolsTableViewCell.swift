import UIKit

class DetailSymbolsTableViewCell: UITableViewCell {
    
    // MARK: - Properties
    var symbolImageView: UIImageView!
    var descriptionLabel: UILabel!
    private var view: UIView!
    private var customSeparator: UIView!
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
        setupSymbolImageView()
        setupDescriptionLabel()
        setupCustomSeparator()
        backgroundColor = Colors.whiteBGColor
        selectionStyle  = .none
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    // MARK: - View
    private func setupView() {
        view                     = UIView()
        view.backgroundColor     = Colors.lightGrayBGColor
        view.layer.cornerRadius  = Constants.defaultCornerRadius
        view.layer.masksToBounds = true
        setupViewConstraints()
    }
    
    private func setupCustomSeparator() {
        customSeparator                 = UIView()
        customSeparator.backgroundColor = Colors.separator
        setupCustomSeparatorConstraints()
    }
    
    // MARK: - SymbolImageView
    private func setupSymbolImageView() {
        symbolImageView             = UIImageView()
        symbolImageView.contentMode = .scaleAspectFit
        setupSymbolImageViewConstraints()
    }
    
    private func setupDescriptionLabel() {
        descriptionLabel = UILabel()
        descriptionLabel.numberOfLines = 0
        descriptionLabel.textColor = Colors.grayTextColor
        descriptionLabel.font = .systemFont(ofSize: Constants.Fonts.smallTextSize, weight: .regular)
        setupDescriptionLabelConstraints()
    }
}

// MARK: - Constraints
extension DetailSymbolsTableViewCell {
    
    private func setupCustomSeparatorConstraints() {
        addSubview(customSeparator)
        
        customSeparator.translatesAutoresizingMaskIntoConstraints                                  = false
        customSeparator.heightAnchor.constraint(equalToConstant: 0.5).isActive                     = true
        customSeparator.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 12).isActive    = true
        customSeparator.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -12).isActive = true
        customSeparator.bottomAnchor.constraint(equalTo: bottomAnchor).isActive                    = true
    }
    
    private func setupSymbolImageViewConstraints() {
        view.addSubview(symbolImageView)
        
        symbolImageView.translatesAutoresizingMaskIntoConstraints                      = false
        symbolImageView.widthAnchor.constraint(equalToConstant: 30).isActive           = true
        symbolImageView.heightAnchor.constraint(equalToConstant: 30).isActive          = true
        symbolImageView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        symbolImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
    }
    
    private func setupViewConstraints() {
        addSubview(view)
        
        view.translatesAutoresizingMaskIntoConstraints                               = false
        view.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16).isActive = true
        view.topAnchor.constraint(equalTo: topAnchor, constant: 8).isActive          = true
        view.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -8).isActive   = true
        view.heightAnchor.constraint(equalToConstant: 42).isActive                   = true
        view.widthAnchor.constraint(equalToConstant: 42).isActive                    = true
    }
    
    private func setupDescriptionLabelConstraints() {
        addSubview(descriptionLabel)
        
        descriptionLabel.translatesAutoresizingMaskIntoConstraints                                  = false
        descriptionLabel.heightAnchor.constraint(equalToConstant: 42).isActive                      = true
        descriptionLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 74).isActive    = true
        descriptionLabel.topAnchor.constraint(equalTo: topAnchor, constant: 8).isActive             = true
        descriptionLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -8).isActive      = true
        descriptionLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -37).isActive = true
    }
}

