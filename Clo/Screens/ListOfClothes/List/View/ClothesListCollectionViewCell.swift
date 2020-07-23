import UIKit

class ClothesListCollectionViewCell: UICollectionViewCell {

    // MARK: - Properties
    var clothesImageView: UIImageView!
    var collectionView: UICollectionView!
    private var shadowView: CloShadowView!
    var symbols: [Symbol]! {
        didSet {
            collectionView.reloadData()
        }
    }

    var color: ColorType!
    var itemHandler: ((CloAlertController) -> Void)!

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
        shadowView                               = CloShadowView()
        shadowView.containerView.backgroundColor = Colors.mainBG
        shadowView.addBorderToContainer()
        shadowView.addTo(view: self)
    }

    // MARK: - ClothesImageView
    private func setupClothesImageView() {
        clothesImageView             = UIImageView()
        clothesImageView.contentMode = .scaleAspectFill
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

    // MARK: - Constraints
    private func setupClothesImageConstraints() {
        shadowView.containerView.addSubview(clothesImageView)
        clothesImageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            clothesImageView.topAnchor.constraint(equalTo: shadowView.topAnchor),
            clothesImageView.leadingAnchor.constraint(equalTo: shadowView.leadingAnchor),
            clothesImageView.trailingAnchor.constraint(equalTo: shadowView.trailingAnchor),
            clothesImageView.heightAnchor.constraint(equalTo: shadowView.widthAnchor, multiplier: 9 / 16)
        ])
    }

    private func setupCollectionViewConstraints() {
        shadowView.containerView.addSubview(collectionView)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            collectionView.leadingAnchor.constraint(equalTo: shadowView.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: shadowView.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: shadowView.bottomAnchor),
            collectionView.heightAnchor.constraint(equalToConstant: 70)
        ])
    }
}
