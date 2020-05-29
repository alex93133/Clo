import UIKit

class TypeTableViewCell: UITableViewCell {
    
    var checkBox: UIImageView!
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupLabel()
        setupCheckBox()
        backgroundColor = Colors.whiteBGColor
        selectionStyle = .none
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        if selected {
            UIView.animate(withDuration: Constants.animationTimeInterval) { [unowned self] in
                self.checkBox.alpha = 1
            }
        } else {
            checkBox.alpha = 0
        }
    }
    
    private func setupLabel() {
        textLabel?.textColor = Colors.blackTextColor
        textLabel?.font = .systemFont(ofSize: Constants.Fonts.mediumTextSize, weight: .regular)
    }
    
    private func setupCheckBox() {
        checkBox = UIImageView()
        checkBox.contentMode = .scaleAspectFill
        checkBox.image = Images.checkBox
        checkBox.alpha = 0
        setupCheckBoxConstraints()
    }
    

}

extension TypeTableViewCell {
    
    private func setupCheckBoxConstraints() {
        addSubview(checkBox)
        
        checkBox.translatesAutoresizingMaskIntoConstraints = false
        checkBox.widthAnchor.constraint(equalToConstant: 28).isActive = true
        checkBox.heightAnchor.constraint(equalToConstant: 28).isActive = true
        checkBox.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        checkBox.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -21).isActive = true
    }
}