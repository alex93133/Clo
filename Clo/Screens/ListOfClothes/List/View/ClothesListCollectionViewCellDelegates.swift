import UIKit

// MARK: - Delegates
extension ClothesListCollectionViewCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_: UICollectionView, numberOfItemsInSection _: Int) -> Int {
        symbols.count + 1
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Identifiers.clothesSymbolsCellIdentifier,
                                                         for: indexPath) as? ClothesSymbolsCollectionViewCell {
            switch indexPath.item {
            case 0:
                let insets = UIEdgeInsets(top: 6, left: 6, bottom: 6, right: 6)
                cell.laundryImageView.image = UIImage(named: color.rawValue)?.withAlignmentRectInsets(insets)

            default:
                let symbol = symbols[indexPath.item - 1]
                cell.laundryImageView.image = symbol.image?.withRenderingMode(.alwaysTemplate)
            }
            return cell
        }
        return UICollectionViewCell()
    }

    func collectionView(_: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        switch indexPath.item {
        case 0:
            return

        default:
            FeedbackManager.select()
            let symbol = symbols[indexPath.item - 1]
            let sheet = CloAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
            itemHandler(sheet)
            sheet.symbol = symbol
        }
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        guard let flowLayout = collectionViewLayout as? UICollectionViewFlowLayout else { return UIEdgeInsets() }
        let numberOfItems = CGFloat(collectionView.numberOfItems(inSection: section))
        let combinedItemWidth = (numberOfItems * flowLayout.itemSize.width) + ((numberOfItems - 1) * flowLayout.minimumInteritemSpacing)
        let padding = (collectionView.frame.width - combinedItemWidth) / 2
        return UIEdgeInsets(top: 0, left: padding, bottom: 0, right: padding)
    }
}
