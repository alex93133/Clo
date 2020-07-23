import UIKit

class LaundryListCollectionViewCell: UICollectionViewCell {

    // MARK: - Properties
    private var shadowView: CloShadowView!
    var laundryNameLabel: UILabel!
    var collectionView: UICollectionView!
    var laundry: Laundry! {
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
        setupLaundryNameLabel()
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
        collectionView.delegate                       = self
        collectionView.dataSource                     = self
        collectionView.semanticContentAttribute       = .forceRightToLeft

        collectionView.register(ClothesSymbolsCollectionViewCell.self, forCellWithReuseIdentifier: Identifiers.clothesSymbolsCellIdentifier)

        setupCollectionViewConstraints()
    }

    // MARK: - LaundryNameLabel
    private func setupLaundryNameLabel() {
        laundryNameLabel           = UILabel()
        laundryNameLabel.textColor = Colors.accent
        laundryNameLabel.font      = .systemFont(ofSize: Constants.Fonts.largeTextSize, weight: .semibold)
        laundryNameLabel.text      = "Privat"
        setupLaundryNameLabelConstraints()
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

    private func setupLaundryNameLabelConstraints() {
        shadowView.containerView.addSubview(laundryNameLabel)
        laundryNameLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            laundryNameLabel.leadingAnchor.constraint(equalTo: shadowView.leadingAnchor, constant: 16),
            laundryNameLabel.heightAnchor.constraint(equalToConstant: 24),
            laundryNameLabel.centerYAnchor.constraint(equalTo: shadowView.centerYAnchor),
            laundryNameLabel.trailingAnchor.constraint(equalTo: collectionView.leadingAnchor)
        ])
    }
}
