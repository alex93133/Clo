import UIKit

class GalleryView: UIView {
   
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
        layout.sectionInset                         = UIEdgeInsets(top: 0, left: 8, bottom: 0, right: 8)

        let numberOfItemsInRow: CGFloat             = 3
        let spacing: CGFloat                        = 4

        let itemSize: CGFloat                       = (frame.size.width - layout.sectionInset.left - layout.sectionInset.right -
            (numberOfItemsInRow - 1) * spacing) / numberOfItemsInRow

        layout.itemSize                             = CGSize(width: itemSize, height: itemSize)
        layout.minimumLineSpacing                   = spacing
        layout.minimumInteritemSpacing              = spacing

        collectionView                              = UICollectionView(frame: frame, collectionViewLayout: layout)
        collectionView.backgroundColor              = Colors.mainBG
        collectionView.showsVerticalScrollIndicator = false

        collectionView.register(GalleryCollectionViewCell.self, forCellWithReuseIdentifier: Identifiers.photoCellIdentifier)
        collectionView.register(CameraCollectionViewCell.self, forCellWithReuseIdentifier: Identifiers.cameraInputCellIdentifier)

        setupCollectionViewConstraints()
    }
}

// MARK: - Constraints
extension GalleryView {
   
    private func setupCollectionViewConstraints() {
        addSubview(collectionView)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([collectionView.leftAnchor.constraint(equalTo: leftAnchor),
                                     collectionView.rightAnchor.constraint(equalTo: rightAnchor),
                                     collectionView.bottomAnchor.constraint(equalTo: bottomAnchor),
                                     collectionView.topAnchor.constraint(equalTo: topAnchor)])
    }
}
