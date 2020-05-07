import UIKit

class PhotoSheetView: UIView {

    // MARK: - Properties
    var collectionView: UICollectionView!

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupCollectionView()
        backgroundColor = Colors.viewBGColor
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    // MARK: - CollectionView
    private func setupCollectionView() {
        let layout                                  = UICollectionViewFlowLayout()
        layout.sectionInset                         = UIEdgeInsets(top: 0, left: 8, bottom: 0, right: 8)

        let numberOfItemsInRow                      = CGFloat(Constants.numberOfPhotosItemsInRow)
        let spacing                                 = Sizes.minimalSpacingBetweenPhotos

        let itemSize: CGFloat                       = (frame.size.width - layout.sectionInset.left - layout.sectionInset.right - (numberOfItemsInRow - 1) * spacing) / numberOfItemsInRow

        layout.itemSize                             = CGSize(width: itemSize, height: itemSize)
        layout.minimumLineSpacing                   = spacing
        layout.minimumInteritemSpacing              = spacing

        collectionView                              = UICollectionView(frame: frame, collectionViewLayout: layout)
        collectionView.backgroundColor              = Colors.viewBGColor
        collectionView.showsVerticalScrollIndicator = false

        collectionView.register(PhotoSheetCollectionViewCell.self, forCellWithReuseIdentifier: Constants.photoCellIdentifier)

        setupCollectionViewConstraints()
    }
}

// MARK: - Constraints
extension PhotoSheetView {

    func setupCollectionViewConstraints() {
        addSubview(collectionView)

        collectionView.translatesAutoresizingMaskIntoConstraints               = false
        collectionView.leftAnchor.constraint(equalTo: leftAnchor).isActive     = true
        collectionView.rightAnchor.constraint(equalTo: rightAnchor).isActive   = true
        collectionView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        collectionView.topAnchor.constraint(equalTo: topAnchor).isActive       = true
    }
}
