import UIKit

class WashingListCollectionViewCell: UICollectionViewCell {

    // MARK: - Properties
    private var shadowView: CloShadowView!
    var washingNameLabel: UILabel!
    var collectionView: UICollectionView!
    var washing: Washing! {
        didSet {
            collectionView.reloadData()
        }
    }
    var itemSelected: (() -> Void)!

    override var isHighlighted: Bool {
        didSet {
            animate()
        }
    }

    override init(frame _: CGRect) {
        super.init(frame: .zero)
        setupView()
        setupCollectionView()
        setupWashingNameLabel()
    }

    required init?(coder _: NSCoder) {
        super.init(frame: .zero)
    }

    // MARK: - View
    private func setupView() {
        shadowView = CloShadowView()
        shadowView.addTo(view: self)
    }

    // MARK: - CollectionView
    private func setupCollectionView() {
        let layout                                    = UICollectionViewFlowLayout()
        layout.sectionInset                           = UIEdgeInsets(top: 12, left: 12, bottom: 12, right: 12)

        let spacing: CGFloat                          = 12
        let itemSize: CGFloat                         = 42

        layout.itemSize                               = CGSize(width: itemSize, height: itemSize)
        layout.minimumLineSpacing                     = spacing
        layout.minimumInteritemSpacing                = spacing
        layout.scrollDirection                        = .horizontal

        collectionView                                = UICollectionView(frame: frame, collectionViewLayout: layout)
        collectionView.backgroundColor                = .clear
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.isScrollEnabled                = false
        collectionView.isUserInteractionEnabled       = false
        collectionView.delegate                       = self
        collectionView.dataSource                     = self
        collectionView.semanticContentAttribute       = .forceRightToLeft

        collectionView.register(ClothesSymbolsCollectionViewCell.self, forCellWithReuseIdentifier: Identifiers.clothesSymbolsCellIdentifier)

        setupCollectionViewConstraints()
    }

    // MARK: - WashingNameLabel
    private func setupWashingNameLabel() {
        washingNameLabel           = UILabel()
        washingNameLabel.textColor = Colors.accent
        washingNameLabel.font      = .systemFont(ofSize: Constants.Fonts.largeTextSize, weight: .semibold)
        setupWashingNameLabelConstraints()
    }

    // MARK: - Constraints
    private func setupCollectionViewConstraints() {
        shadowView.containerView.addSubview(collectionView)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            collectionView.widthAnchor.constraint(equalToConstant: 174),
            collectionView.topAnchor.constraint(equalTo: shadowView.topAnchor),
            collectionView.trailingAnchor.constraint(equalTo: shadowView.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: shadowView.bottomAnchor)
        ])
    }

    private func setupWashingNameLabelConstraints() {
        shadowView.containerView.addSubview(washingNameLabel)
        washingNameLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            washingNameLabel.leadingAnchor.constraint(equalTo: shadowView.leadingAnchor, constant: 16),
            washingNameLabel.heightAnchor.constraint(equalToConstant: 24),
            washingNameLabel.centerYAnchor.constraint(equalTo: shadowView.centerYAnchor),
            washingNameLabel.trailingAnchor.constraint(equalTo: collectionView.leadingAnchor)
        ])
    }
}
