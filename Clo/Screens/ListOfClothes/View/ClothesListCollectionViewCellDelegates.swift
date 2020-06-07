import UIKit

// MARK: - Delegates
extension ClothesListCollectionViewCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        symbols.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Identifiers.clothesSymbolsCellIdentifier, for: indexPath) as? ClothesSymbolsCollectionViewCell {
            cell.laundryImageView.image = symbols[indexPath.item].image
            return cell
        }
        return UICollectionViewCell()
    }
}
