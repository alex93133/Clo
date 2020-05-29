import UIKit

class ClothesSymbolsCollectionViewCell: UICollectionViewCell {

    // MARK: - Properties
    var laundryImageView: UIImageView!

    override init(frame: CGRect) {
        super.init(frame: .zero)
        setupView()
        setupLaundryImageView(itemSize: frame.width)
    }

    required init?(coder: NSCoder) {
        super.init(frame: .zero)
    }

    // MARK: - View
    private func setupView() {
        layer.cornerRadius  = Constants.defaultCornerRadius
        layer.borderColor   = UIColor.clear.cgColor
        layer.masksToBounds = true
        backgroundColor     = Colors.lightGrayBGColor
    }

    // MARK: - LaundryImageView
    private func setupLaundryImageView(itemSize: CGFloat) {
        laundryImageView             = UIImageView(frame: CGRect(x: 0, y: 0, width: itemSize - 6, height: itemSize - 6))
        laundryImageView.center      = CGPoint(x: itemSize / 2, y: itemSize / 2)
        laundryImageView.contentMode = .scaleAspectFit

        let symbols                  = Symbols.allSymbols()
        laundryImageView.image       = symbols![0].image

        addSubview(laundryImageView)
    }
}
