import UIKit

class ClothesListCollectionViewCell: UICollectionViewCell {

    // MARK: - Properties
    var clothesImageView: UIImageView!
    var lineView: UIView!
    var collectionView: UICollectionView!
    var symbols: [Symbol]!

    override init(frame: CGRect) {
        super.init(frame: .zero)
        setupView()
        setupClothesImageView(itemSize: frame.width)
        setupCollectionView()
        setupLineView(rect: frame)

        collectionView.delegate   = self
        collectionView.dataSource = self
    }

    required init?(coder: NSCoder) {
        super.init(frame: .zero)
    }

    // MARK: - View
    private func setupView() {
        layer.cornerRadius  = Constants.defaultCornerRadius
        layer.borderColor   = UIColor.clear.cgColor
        layer.masksToBounds = true
        backgroundColor     = Colors.whiteBGColor
    }

    // MARK: - ClothesImageView
    private func setupClothesImageView(itemSize: CGFloat) {
        clothesImageView             = UIImageView()
        clothesImageView.contentMode = .scaleAspectFill

        setupClothesImageConstraints()
    }

    // MARK: - LineView
    private func setupLineView(rect: CGRect) {
        lineView                 = UIView(frame: CGRect(x: 0, y: 0, width: rect.width - 24, height: 1))
        lineView.center          = CGPoint(x: rect.width / 2, y: 283)
        lineView.backgroundColor = Colors.lightGrayBGColor

        addSubview(lineView)
    }
    // MARK: - CollectionView
    private func setupCollectionView() {
        let layout                                    = UICollectionViewFlowLayout()
        layout.sectionInset                           = UIEdgeInsets(top: 14, left: 16, bottom: 14, right: 16)

        let spacing: CGFloat                          = 4
        let itemSize: CGFloat                         = 42

        layout.itemSize                               = CGSize(width: itemSize, height: itemSize)
        layout.minimumLineSpacing                     = spacing
        layout.minimumInteritemSpacing                = spacing
        layout.scrollDirection                        = .horizontal

        collectionView                                = UICollectionView(frame: frame, collectionViewLayout: layout)
        collectionView.backgroundColor                = .clear
        collectionView.showsHorizontalScrollIndicator = false

        collectionView.register(ClothesSymbolsCollectionViewCell.self, forCellWithReuseIdentifier: Identifiers.clothesSymbolsCellIdentifier)

        setupCollectionViewConstraints()
    }
}

// MARK: - Constraints
extension ClothesListCollectionViewCell {

    private func setupClothesImageConstraints() {
        addSubview(clothesImageView)

        clothesImageView.translatesAutoresizingMaskIntoConstraints                                             = false
        clothesImageView.topAnchor.constraint(equalTo: topAnchor).isActive                                     = true
        clothesImageView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive                             = true
        clothesImageView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive                           = true
        clothesImageView.heightAnchor.constraint(equalTo: widthAnchor, multiplier: 9 / 16).isActive = true
    }

    private func setupCollectionViewConstraints() {
        addSubview(collectionView)

        collectionView.translatesAutoresizingMaskIntoConstraints                   = false
        collectionView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive   = true
        collectionView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        collectionView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive     = true
        collectionView.heightAnchor.constraint(equalToConstant: 70).isActive       = true
    }
}
