import UIKit

class LaundrySymbolsView: UIView {

    // MARK: - Properties
    var headLabel: UILabel!
    var collectionView: UICollectionView!

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupCollectionView()
        backgroundColor = Colors.lightGrayBGColor
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    // MARK: - CollectionView
    private func setupCollectionView() {
        let layout                                  = UICollectionViewFlowLayout()
        layout.sectionInset                         = UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16)

        let numberOfItemsInRow: CGFloat             = 5
        let spacing: CGFloat                        = 8

        let itemSize: CGFloat                       = (frame.size.width - layout.sectionInset.left - layout.sectionInset.right - (numberOfItemsInRow - 1) * spacing) / numberOfItemsInRow

        layout.itemSize                             = CGSize(width: itemSize, height: itemSize)
        layout.minimumLineSpacing                   = spacing
        layout.minimumInteritemSpacing              = spacing

        collectionView                              = UICollectionView(frame: frame, collectionViewLayout: layout)
        collectionView.backgroundColor              = Colors.lightGrayBGColor
        collectionView.showsVerticalScrollIndicator = false

        collectionView.register(LaundrySymbolsCollectionViewCell.self, forCellWithReuseIdentifier: Identifiers.symbolCellIdentifier)
        collectionView.register(LaundrySymbolsHeader.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: Identifiers.symbolHeaderIdentifier)

        setupCollectionViewConstraints()
    }
}

// MARK: - Constraints
extension LaundrySymbolsView {

    fileprivate func setupCollectionViewConstraints() {
        addSubview(collectionView)

        collectionView.translatesAutoresizingMaskIntoConstraints               = false
        collectionView.leftAnchor.constraint(equalTo: leftAnchor).isActive     = true
        collectionView.rightAnchor.constraint(equalTo: rightAnchor).isActive   = true
        collectionView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        collectionView.topAnchor.constraint(equalTo: topAnchor).isActive       = true
    }
}
