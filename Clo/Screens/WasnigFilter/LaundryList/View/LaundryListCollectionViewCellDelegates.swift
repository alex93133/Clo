import UIKit

extension LaundryListCollectionViewCell: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return laundry.coincidence ? 3 : 2
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Identifiers.clothesSymbolsCellIdentifier, for: indexPath) as? ClothesSymbolsCollectionViewCell {
            cell.backgroundColor = Colors.border
            switch indexPath.item {
            // Mirrored collection view
            case 0:
                let insets = UIEdgeInsets(top: 6, left: 6, bottom: 6, right: 6)
                let colorName = laundry.color.rawValue
                cell.laundryImageView.image = UIImage(named: colorName)?.withAlignmentRectInsets(insets)

            case 1:
                let symbol = WashingManager.getWashingSymbol(data: .parameters(laundry.washingMode,
                                                                               laundry.temperature))
                cell.laundryImageView.image = symbol.image

            case 2:
                cell.laundryImageView.image = Images.coincidenceIcon

            default:
                return UICollectionViewCell()
            }
            return cell
        }
        return UICollectionViewCell()
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        itemSelected()
    }
}
