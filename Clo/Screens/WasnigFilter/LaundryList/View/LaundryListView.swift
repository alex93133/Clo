import UIKit

class LaundryListView: UIView {

    // MARK: - Properties
    var collectionView: UICollectionView!

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupCollectionView()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    private func setupView() {
    }

    private func setupCollectionView() {
        let layout                                  = UICollectionViewFlowLayout()
        layout.sectionInset                         = UIEdgeInsets(top: 8, left: 16, bottom: 32, right: 16)

        let spacing: CGFloat                        = 24
        layout.minimumLineSpacing                   = spacing
        layout.minimumInteritemSpacing              = spacing

        collectionView                              = UICollectionView(frame: frame, collectionViewLayout: layout)
        collectionView.backgroundColor              = Colors.mainBG
        collectionView.showsVerticalScrollIndicator = false
        collectionView.delaysContentTouches         = false

        collectionView.register(AddNewItemCollectionViewCell.self, forCellWithReuseIdentifier: Identifiers.addNewItemCellIdentifier)
        collectionView.register(LaundryListCollectionViewCell.self, forCellWithReuseIdentifier: Identifiers.laundryCellIdentifier)

        setupCollectionViewConstraints()
    }

    // MARK: - Constraints
    private func setupCollectionViewConstraints() {
        addSubview(collectionView)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            collectionView.leadingAnchor.constraint(equalTo: leadingAnchor),
            collectionView.topAnchor.constraint(equalTo: topAnchor),
            collectionView.trailingAnchor.constraint(equalTo: trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
}
