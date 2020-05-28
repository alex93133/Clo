import UIKit

class GalleryView: UIView {

    // MARK: - Properties
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
        layout.sectionInset                         = UIEdgeInsets(top: 0, left: 8, bottom: 0, right: 8)

        let numberOfItemsInRow: CGFloat             = 3
        let spacing: CGFloat                        = 4

        let itemSize: CGFloat                       = (frame.size.width - layout.sectionInset.left - layout.sectionInset.right - (numberOfItemsInRow - 1) * spacing) / numberOfItemsInRow

        layout.itemSize                             = CGSize(width: itemSize, height: itemSize)
        layout.minimumLineSpacing                   = spacing
        layout.minimumInteritemSpacing              = spacing

        collectionView                              = UICollectionView(frame: frame, collectionViewLayout: layout)
        collectionView.backgroundColor              = Colors.lightGrayBGColor
        collectionView.showsVerticalScrollIndicator = false

        collectionView.register(GalleryCollectionViewCell.self, forCellWithReuseIdentifier: Identifiers.photoCellIdentifier)
        collectionView.register(CameraCollectionViewCell.self, forCellWithReuseIdentifier: Identifiers.cameraInputCellIdentifier)

        setupCollectionViewConstraints()
    }
}

// MARK: - Constraints
extension GalleryView {

    fileprivate func setupCollectionViewConstraints() {
        addSubview(collectionView)

        collectionView.translatesAutoresizingMaskIntoConstraints               = false
        collectionView.leftAnchor.constraint(equalTo: leftAnchor).isActive     = true
        collectionView.rightAnchor.constraint(equalTo: rightAnchor).isActive   = true
        collectionView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        collectionView.topAnchor.constraint(equalTo: topAnchor).isActive       = true
    }
}
