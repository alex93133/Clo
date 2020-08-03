import UIKit

// MARK: - Delegates
extension WashingListCollectionViewCell: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return washing.coincidence ? 3 : 2
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Identifiers.clothesSymbolsCellIdentifier,
                                                         for: indexPath) as? ClothesSymbolsCollectionViewCell {
            cell.backgroundColor = UIColor(red: 0.667, green: 0.667, blue: 0.667, alpha: 0.1)
            switch indexPath.item {
            // Mirrored collection view
            case 0:
                let insets = UIEdgeInsets(top: 6, left: 6, bottom: 6, right: 6)
                let colorName = washing.color.rawValue
                cell.washingImageView.image = UIImage(named: colorName)?.withAlignmentRectInsets(insets)

            case 1:
                let symbol = WashingManager.getWashingSymbol(data: .parameters(washing.washingMode,
                                                                               washing.temperature))
                cell.washingImageView.image = symbol.image

            case 2:
                cell.washingImageView.image = Images.coincidenceIcon?.withTintColor(Colors.accent)

            default:
                return UICollectionViewCell()
            }
            return cell
        }
        return UICollectionViewCell()
    }
}
