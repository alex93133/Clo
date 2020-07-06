import UIKit

class LaundrySymbolsView: UIView {

    // MARK: - Properties
    var collectionView: UICollectionView!

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupCollectionView()
        backgroundColor = Colors.mainBG
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    // MARK: - CollectionView
    private func setupCollectionView() {
        let layout                                  = UICollectionViewFlowLayout()
        layout.sectionInset                         = UIEdgeInsets(top: 16, left: 16, bottom: 32, right: 16)

        let numberOfItemsInRow: CGFloat             = 5
        let spacing: CGFloat                        = 8

        let itemSize: CGFloat                       = (frame.size.width - layout.sectionInset.left - layout.sectionInset.right -
            (numberOfItemsInRow - 1) * spacing) / numberOfItemsInRow

        layout.itemSize                             = CGSize(width: itemSize, height: itemSize)
        layout.minimumLineSpacing                   = spacing
        layout.minimumInteritemSpacing              = spacing

        collectionView                              = UICollectionView(frame: frame, collectionViewLayout: layout)
        collectionView.backgroundColor              = Colors.mainBG
        collectionView.showsVerticalScrollIndicator = false
        collectionView.delaysContentTouches         = false

        collectionView.register(LaundrySymbolsCollectionViewCell.self, forCellWithReuseIdentifier: Identifiers.symbolCellIdentifier)
        collectionView.register(LaundrySymbolsHeader.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: Identifiers.symbolHeaderIdentifier)

        setupCollectionViewConstraints()
    }

    // MARK: - Constraints
    private func setupCollectionViewConstraints() {
        addSubview(collectionView)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            collectionView.leftAnchor.constraint(equalTo: leftAnchor),
            collectionView.rightAnchor.constraint(equalTo: rightAnchor),
            collectionView.bottomAnchor.constraint(equalTo: bottomAnchor),
            collectionView.topAnchor.constraint(equalTo: topAnchor)
        ])
    }
}
