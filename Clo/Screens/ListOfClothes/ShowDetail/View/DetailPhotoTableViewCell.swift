import UIKit

class DetailPhotoTableViewCell: UITableViewCell {

    // MARK: - Properties
    var photoImageView: UIImageView!

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupPhotoImageView()
        backgroundColor = Colors.whiteBGColor
        selectionStyle  = .none
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    // MARK: - PhotoImageView
    private func setupPhotoImageView() {
        photoImageView                     = UIImageView()
        photoImageView.contentMode         = .scaleAspectFill
        photoImageView.layer.cornerRadius  = Constants.defaultCornerRadius
        photoImageView.layer.masksToBounds = true
        setupPhotoImageViewConstraints()
    }
}

// MARK: - Constraints
extension DetailPhotoTableViewCell {

    private func setupPhotoImageViewConstraints() {
        addSubview(photoImageView)

        photoImageView.translatesAutoresizingMaskIntoConstraints                                  = false
        photoImageView.topAnchor.constraint(equalTo: topAnchor).isActive                          = true
        photoImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 12).isActive    = true
        photoImageView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -12).isActive = true
        photoImageView.heightAnchor.constraint(equalTo: widthAnchor, multiplier: 9 / 16).isActive = true
        photoImageView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive                    = true
    }
}
