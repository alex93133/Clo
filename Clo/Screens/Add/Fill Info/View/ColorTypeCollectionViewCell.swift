import UIKit

class ColorTypeCollectionViewCell: UICollectionViewCell {

    // MARK: - Properties
    var colorTypeImageView: UIImageView!

    override init(frame: CGRect) {
        super.init(frame: .zero)
        setupColorTypeImageView(itemSize: frame.height)
    }

    required init?(coder: NSCoder) {
        super.init(frame: .zero)
    }

    // MARK: - TypeImageView
    private func setupColorTypeImageView(itemSize: CGFloat) {
        colorTypeImageView                     = UIImageView(frame: CGRect(x: 0, y: 0, width: itemSize, height: itemSize))
        colorTypeImageView.center              = CGPoint(x: itemSize / 2, y: itemSize / 2)
        colorTypeImageView.contentMode         = .scaleAspectFill

        colorTypeImageView.layer.borderWidth   = 5
        colorTypeImageView.layer.borderColor   = UIColor.clear.cgColor
        colorTypeImageView.layer.cornerRadius  = Constants.defaultCornerRadius
        colorTypeImageView.layer.masksToBounds = true

        colorTypeImageView.layer.shadowColor   = UIColor(red: 0, green: 0, blue: 0, alpha: 0.25).cgColor
        colorTypeImageView.layer.shadowOpacity = 1
        colorTypeImageView.layer.shadowOffset  = CGSize(width: 0, height: 4)
        colorTypeImageView.layer.shadowRadius  = Constants.shadowRadius

        addSubview(colorTypeImageView)
    }

}
