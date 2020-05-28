import UIKit

// MARK: - Delegates
extension ClothesListCollectionViewCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        4
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Identifiers.clothesSymbolsCellIdentifier, for: indexPath) as? ClothesSymbolsCollectionViewCell {
            //            cell.backgroundColor = .red
            return cell
        }
        return UICollectionViewCell()
    }
}
