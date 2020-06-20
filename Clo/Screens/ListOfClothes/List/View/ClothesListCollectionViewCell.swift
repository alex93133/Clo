import UIKit

class ClothesListCollectionViewCell: UICollectionViewCell {
    
    // MARK: - Properties
    var clothesImageView: UIImageView!
    var collectionView: UICollectionView!
    var symbols: [Symbol]! {
        didSet {
            collectionView.reloadData()
        }
    }

    var color: ColorType!
    var itemHandler: ((CustomAlertController) -> Void)!

    override var isHighlighted: Bool {
        didSet {
            animate()
        }
    }

    override init(frame _: CGRect) {
        super.init(frame: .zero)
        setupView()
        setupClothesImageView()
        setupCollectionView()

        collectionView.delegate   = self
        collectionView.dataSource = self
    }

    required init?(coder _: NSCoder) {
        super.init(frame: .zero)
    }

    // MARK: - View
    private func setupView() {
        contentView.layer.cornerRadius  = Constants.defaultCornerRadius
        contentView.backgroundColor     = Colors.mainBG

        contentView.layer.shadowColor   = UIColor(red: 0, green: 0, blue: 0, alpha: 0.25).cgColor
        contentView.layer.shadowOpacity = 1
        contentView.layer.shadowOffset  = CGSize(width: 0, height: 2)
        contentView.layer.shadowRadius  = Constants.shadowRadius
    }

    // MARK: - ClothesImageView
    private func setupClothesImageView() {
        clothesImageView                     = UIImageView()
        clothesImageView.contentMode         = .scaleAspectFill
        clothesImageView.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
        clothesImageView.layer.cornerRadius  = Constants.defaultCornerRadius
        clothesImageView.layer.masksToBounds = true
        setupClothesImageConstraints()
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
        collectionView.isScrollEnabled                = false

        collectionView.register(ClothesSymbolsCollectionViewCell.self, forCellWithReuseIdentifier: Identifiers.clothesSymbolsCellIdentifier)

        setupCollectionViewConstraints()
    }
}

// MARK: - Constraints
extension ClothesListCollectionViewCell {
  
    private func setupClothesImageConstraints() {
        contentView.addSubview(clothesImageView)
        clothesImageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([clothesImageView.topAnchor.constraint(equalTo: contentView.topAnchor),
                                     clothesImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
                                     clothesImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
                                     clothesImageView.heightAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 9 / 16)])
    }

    private func setupCollectionViewConstraints() {
        addSubview(collectionView)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([collectionView.leadingAnchor.constraint(equalTo: leadingAnchor),
                                     collectionView.trailingAnchor.constraint(equalTo: trailingAnchor),
                                     collectionView.bottomAnchor.constraint(equalTo: bottomAnchor),
                                     collectionView.heightAnchor.constraint(equalToConstant: 70)])
    }
}
