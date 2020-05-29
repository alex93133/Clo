import UIKit

class ClothesListCollectionViewCell: UICollectionViewCell {

    // MARK: - Properties
    var clothesImageView: UIImageView!
    var clothesName: UILabel!
    var lineView: UIView!
    var collectionView: UICollectionView!

    override init(frame: CGRect) {
        super.init(frame: .zero)
        setupView()
        setupClothesImageView(itemSize: frame.width)
        setupClothesName()
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

    // MARK: - ClothesName
    private func setupClothesName() {
        clothesName           = UILabel()
        clothesName.font      = UIFont.systemFont(ofSize: Constants.Fonts.clothesNameTextSize, weight: .bold)
        clothesName.textColor = Colors.blackTextColor

        setupClothesNameConstraints()
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

        clothesImageView.translatesAutoresizingMaskIntoConstraints                                                    = false
        clothesImageView.topAnchor.constraint(equalToSystemSpacingBelow: topAnchor, multiplier: 0).isActive           = true
        clothesImageView.leadingAnchor.constraint(equalToSystemSpacingAfter: leadingAnchor, multiplier: 0).isActive   = true
        clothesImageView.trailingAnchor.constraint(equalToSystemSpacingAfter: trailingAnchor, multiplier: 0).isActive = true
        clothesImageView.heightAnchor.constraint(equalToConstant: 203).isActive                                       = true
    }

    private func setupClothesNameConstraints() {
        addSubview(clothesName)

        clothesName.translatesAutoresizingMaskIntoConstraints                                                     = false
        clothesName.heightAnchor.constraint(equalToConstant: 32).isActive                                         = true
        clothesName.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16).isActive                       = true
        clothesName.trailingAnchor.constraint(equalToSystemSpacingAfter: trailingAnchor, multiplier: 16).isActive = true
        clothesName.topAnchor.constraint(equalTo: topAnchor, constant: 227).isActive                              = true
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
