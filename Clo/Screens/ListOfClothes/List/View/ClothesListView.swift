import UIKit

class ClothesListView: UIView {

    // MARK: - Properties
    var collectionView: UICollectionView!

    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = Colors.mainBG
        setupCollectionView()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    // MARK: - CollectionView
    private func setupCollectionView() {
        let layout                                  = UICollectionViewFlowLayout()
        layout.sectionInset                         = UIEdgeInsets(top: 8, left: 16, bottom: 16, right: 16)

        let spacing: CGFloat                        = 24
        layout.minimumLineSpacing                   = spacing

        collectionView                              = UICollectionView(frame: frame, collectionViewLayout: layout)
        collectionView.backgroundColor              = Colors.mainBG
        collectionView.showsVerticalScrollIndicator = false
        collectionView.delaysContentTouches         = false

        collectionView.register(AddNewItemCollectionViewCell.self, forCellWithReuseIdentifier: Identifiers.addNewItemCellIdentifier)
        collectionView.register(ClothesListCollectionViewCell.self, forCellWithReuseIdentifier: Identifiers.clothesCellIdentifier)

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
