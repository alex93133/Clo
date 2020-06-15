import UIKit

class LaundrySymbolsViewController: UIViewController {

    // MARK: - Properties
    private let customView = LaundrySymbolsView(frame: UIScreen.main.bounds)
    private let symbolSections = SymbolsSections.getSections()

    // MARK: - Lifecycle
    override func viewDidLoad() {
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
        navigationItem.title = "Information"
    }
}

// MARK: - Delegates
extension LaundrySymbolsViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Identifiers.symbolCellIdentifier, for: indexPath) as! LaundrySymbolsCollectionViewCell

        let section = symbolSections[indexPath.section]
        cell.laundryImage.image = section.items[indexPath.item].image

        return cell
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        symbolSections[section].items.count
    }

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        symbolSections.count
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let sheet = CustomAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        present(sheet, animated: true)
        sheet.symbol = symbolSections[indexPath.section].items[indexPath.item]
    }

    func collectionView(_ collectionView: UICollectionView,
                        viewForSupplementaryElementOfKind kind: String,
                        at indexPath: IndexPath) -> UICollectionReusableView {
        if kind == UICollectionView.elementKindSectionHeader {
            let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: Identifiers.symbolHeaderIdentifier, for: indexPath) as! LaundrySymbolsHeader
            headerView.headerLabel.text = symbolSections[indexPath.section].title
            return headerView
        }
        return UICollectionReusableView()
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: 80.0)
    }
}
