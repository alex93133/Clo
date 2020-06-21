import UIKit

class LaundrySymbolsCollectionViewCell: UICollectionViewCell {

    // MARK: - Properties
    var laundryImage: UIImageView!

    override var isHighlighted: Bool {
        didSet {
            animate()
        }
    }

    override init(frame: CGRect) {
        super.init(frame: .zero)
        setupView(itemSize: frame.size.height)
        setupLaundryImage(itemSize: frame.size.height)
    }

    required init?(coder _: NSCoder) {
        super.init(frame: .zero)
    }

    // MARK: - View
    private func setupView(itemSize: CGFloat) {
        contentView.center              = CGPoint(x: itemSize / 2, y: itemSize / 2)
        contentView.layer.cornerRadius  = Constants.defaultCornerRadius
        contentView.backgroundColor     = Colors.mainBG

        contentView.layer.shadowColor   = UIColor(red: 0, green: 0, blue: 0, alpha: 0.25).cgColor
        contentView.layer.shadowOpacity = 1
        contentView.layer.shadowOffset  = CGSize(width: 0, height: 4)
        contentView.layer.shadowRadius  = Constants.shadowRadius
    }

    // MARK: - LaundryImage
    private func setupLaundryImage(itemSize: CGFloat) {
        let spacing: CGFloat     = itemSize / 2
        laundryImage             = UIImageView(frame: CGRect(x: 0, y: 0, width: itemSize - spacing, height: itemSize - spacing))
        laundryImage.center      = CGPoint(x: itemSize / 2, y: itemSize / 2)
        laundryImage.contentMode = .scaleAspectFit
        laundryImage.tintColor   = Colors.accent

        addSubview(laundryImage)
    }
}
