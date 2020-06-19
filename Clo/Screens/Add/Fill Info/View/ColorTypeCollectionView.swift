import UIKit

class ColorTypeCollectionView: UIView {
    
    // MARK: - Properties
    var collectionView: UICollectionView!
    
    init() {
        super.init(frame: UIScreen.main.bounds)
        setupCollectionView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    // MARK: - CollectionView
    private func setupCollectionView() {
        let layout                                  = UICollectionViewFlowLayout()
        layout.sectionInset                         = UIEdgeInsets(top: 16, left: 12, bottom: 16, right: 12)
        
        let spacing: CGFloat                        = 0
        let itemSize: CGFloat                       = 62
        
        layout.itemSize                             = CGSize(width: itemSize, height: itemSize)
        layout.minimumLineSpacing                   = spacing
        layout.minimumInteritemSpacing              = spacing
        
        collectionView                              = UICollectionView(frame: frame, collectionViewLayout: layout)
        collectionView.backgroundColor              = Colors.whiteBGColor
        collectionView.showsVerticalScrollIndicator = false
        
        collectionView.register(ColorTypeCollectionViewCell.self, forCellWithReuseIdentifier: Identifiers.clothesColorCellIdentifier)
        setupCollectionViewConstraints()
    }
}

// MARK: - Constraints
extension ColorTypeCollectionView {
    
    private func setupCollectionViewConstraints() {
        addSubview(collectionView)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([collectionView.leadingAnchor.constraint(equalTo: leadingAnchor),
                                     collectionView.trailingAnchor.constraint(equalTo: trailingAnchor),
                                     collectionView.topAnchor.constraint(equalTo: topAnchor),
                                     collectionView.bottomAnchor.constraint(equalTo: bottomAnchor)])
    }
}
