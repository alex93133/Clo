import UIKit

class ClothesListView: UIView {

    // MARK: - Properties
    var collectionView: UICollectionView!

    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = Colors.lightGrayBGColor
        setupCollectionView()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    // MARK: - CollectionView
    private func setupCollectionView() {
        let layout                                  = UICollectionViewFlowLayout()
        layout.sectionInset                         = UIEdgeInsets(top: 0, left: 16, bottom: 16, right: 16)

        let spacing: CGFloat                        = 24
        let itemWidth: CGFloat                      = frame.size.width - layout.sectionInset.left - layout.sectionInset.right
        let itemHeight: CGFloat                     = itemWidth / 1.3

        layout.itemSize                             = CGSize(width: itemWidth, height: itemHeight)
        layout.minimumLineSpacing                   = spacing

        collectionView                              = UICollectionView(frame: frame, collectionViewLayout: layout)
        collectionView.backgroundColor              = Colors.lightGrayBGColor
        collectionView.showsVerticalScrollIndicator = false

        collectionView.register(ClothesListCollectionViewCell.self, forCellWithReuseIdentifier: Identifiers.clothesCellIdentifier)
        collectionView.register(AddNewItemCollectionViewCell.self, forCellWithReuseIdentifier: Identifiers.addNewItemCellIdentifier)

        setupCollectionViewConstraints()
    }
}

// MARK: - Constraints
extension ClothesListView {

    private func setupCollectionViewConstraints() {
        addSubview(collectionView)

        collectionView.translatesAutoresizingMaskIntoConstraints               = false
        collectionView.leftAnchor.constraint(equalTo: leftAnchor).isActive     = true
        collectionView.rightAnchor.constraint(equalTo: rightAnchor).isActive   = true
        collectionView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        collectionView.topAnchor.constraint(equalTo: topAnchor).isActive       = true
    }
}
