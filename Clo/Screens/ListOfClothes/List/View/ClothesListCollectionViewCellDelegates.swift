import UIKit

// MARK: - Delegates
extension ClothesListCollectionViewCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        symbols.count + 1
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Identifiers.clothesSymbolsCellIdentifier, for: indexPath) as? ClothesSymbolsCollectionViewCell {
            
            switch indexPath.item {
            case 0:
                let insets = UIEdgeInsets(top: 6, left: 6, bottom: 6, right: 6)
                cell.laundryImageView.image = UIImage(named: color.rawValue)?.withAlignmentRectInsets(insets)
            default:
                cell.laundryImageView.image = symbols[indexPath.item - 1].image
            }
            return cell
        }
        return UICollectionViewCell()
    }
}
