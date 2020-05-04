import UIKit

class LaundrySymbolsView: UIView {

    // MARK: - Properties
    var headLabel: UILabel!
    var collectionView: UICollectionView!

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupCollectionView()
        setupHeadLabel()
        backgroundColor = Colors.viewBGColor
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    // MARK: - HeadLabel
    private func setupHeadLabel() {
        headLabel               = UILabel()
        headLabel.text          = "Recommendation"
        headLabel.font          = .systemFont(ofSize: Sizes.headTextSize, weight: .bold)
        headLabel.textColor     = Colors.textColor
        headLabel.textAlignment = .left
        setHeadLabelConstraints()
    }

    // MARK: - CollectionView
    private func setupCollectionView() {
        let layout                                  = UICollectionViewFlowLayout()
        layout.sectionInset                         = UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16)

        let numberOfItemsInRow                      = CGFloat(Constants.numberOfSymbolsItemsInRow)
        let spacing                                 = Sizes.minimalSpacingBetweenSymbols

        let itemSize: CGFloat                       = (frame.size.width - layout.sectionInset.left - layout.sectionInset.right - (numberOfItemsInRow - 1) * spacing) / numberOfItemsInRow

        layout.itemSize                             = CGSize(width: itemSize, height: itemSize)
        layout.minimumLineSpacing                   = spacing
        layout.minimumInteritemSpacing              = spacing

        collectionView                              = UICollectionView(frame: frame, collectionViewLayout: layout)
        collectionView.backgroundColor              = Colors.viewBGColor
        collectionView.showsVerticalScrollIndicator = false

        collectionView.register(LaundrySymbolsCollectionViewCell.self, forCellWithReuseIdentifier: Constants.symbolCellIdentifier)
        collectionView.register(LaundrySymbolsHeader.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: Constants.symbolHeaderIdentifier)

        setupCollectionViewConstraints()
    }
}

// MARK: - Constraints
extension LaundrySymbolsView {

    func setupCollectionViewConstraints() {
        addSubview(collectionView)

        collectionView.translatesAutoresizingMaskIntoConstraints                             = false
        collectionView.leftAnchor.constraint(equalTo: leftAnchor).isActive                   = true
        collectionView.rightAnchor.constraint(equalTo: rightAnchor).isActive                 = true
        collectionView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive               = true
        collectionView.topAnchor.constraint(equalTo: topAnchor, constant: 124).isActive      = true
    }

    func setHeadLabelConstraints() {
        addSubview(headLabel)

        headLabel.translatesAutoresizingMaskIntoConstraints                                  = false
        headLabel.topAnchor.constraint(equalTo: topAnchor, constant: 80).isActive            = true
        headLabel.heightAnchor.constraint(equalToConstant: 32).isActive                      = true
        headLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16).isActive    = true
        headLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16).isActive = true
    }
}
