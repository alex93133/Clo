import UIKit

class LaundrySymbolsViewController: UIViewController {

    // MARK: - Properties
    let customView = LaundrySymbolsView(frame: UIScreen.main.bounds)

    // MARK: - Lifecycle
    override func loadView() {
        setupView()
    }

    // MARK: - Functions
    private func view() -> LaundrySymbolsView {
        return view as! LaundrySymbolsView
    }

    private func setupView() {
        view  =  customView
        view().collectionView.dataSource = self
        view().collectionView.delegate = self
    }
}

// MARK: - CollectionViewDelegates

extension LaundrySymbolsViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Constants.symbolCellIdentifier, for: indexPath) as? LaundrySymbolsCollectionViewCell {
            return cell
        } else {
            return UICollectionViewCell()
        }
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        20
    }

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        2
    }

    func collectionView(_ collectionView: UICollectionView,
                        viewForSupplementaryElementOfKind kind: String,
                        at indexPath: IndexPath) -> UICollectionReusableView {
        if kind == UICollectionView.elementKindSectionHeader {
            let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: Constants.symbolHeaderIdentifier, for: indexPath)
            return headerView
        }
        return UICollectionReusableView()
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: 80.0)
    }
}
