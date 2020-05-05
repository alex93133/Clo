import UIKit

class LaundrySymbolsCollectionViewCell: UICollectionViewCell {

    // MARK: - Properties
    var laundryImage: UIImageView!

    override init(frame: CGRect) {
        super.init(frame: .zero)
        setupView(itemSize: frame.size.height)
        setupLaundryImage(itemSize: frame.size.height)
    }

    required init?(coder: NSCoder) {
        super.init(frame: .zero)
    }

    // MARK: - View
    private func setupView(itemSize: CGFloat) {
        let view                 = UIView(frame: CGRect(x: 0, y: 0, width: itemSize, height: itemSize))
        view.center              = CGPoint(x: itemSize / 2, y: itemSize / 2)
        view.layer.cornerRadius  = Sizes.defaultCornerRadius
        view.backgroundColor     = Colors.cellColor

        view.layer.shadowColor   = UIColor(red: 0, green: 0, blue: 0, alpha: 0.25).cgColor
        view.layer.shadowOpacity = 1
        view.layer.shadowOffset  = CGSize(width: 0, height: 4)
        view.layer.shadowRadius  = Sizes.shadowRadius

        addSubview(view)
    }

    // MARK: - LaundryImage
    private func setupLaundryImage(itemSize: CGFloat) {
        let spacing: CGFloat            = 20
        laundryImage                    = UIImageView(frame: CGRect(x: 0, y: 0, width: itemSize - spacing, height: itemSize - spacing))
        laundryImage.center             = CGPoint(x: itemSize / 2, y: itemSize / 2)
        laundryImage.layer.cornerRadius = Sizes.defaultCornerRadius
        laundryImage.contentMode        = .scaleAspectFit

        addSubview(laundryImage)
    }
}
