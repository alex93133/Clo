import UIKit

class DetailPhotoTableViewCell: UITableViewCell {

    // MARK: - Properties
    var photoImageView: UIImageView!

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupPhotoImageView()
        backgroundColor = Colors.mainBG
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

    // MARK: - Constraints
    private func setupPhotoImageViewConstraints() {
        addSubview(photoImageView)
        photoImageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            photoImageView.topAnchor.constraint(equalTo: topAnchor),
            photoImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 12),
            photoImageView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -12),
            photoImageView.heightAnchor.constraint(equalTo: widthAnchor, multiplier: 9 / 16),
            photoImageView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
}
