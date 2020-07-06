import UIKit

class LaundrySymbolsViewController: UIViewController {

    // MARK: - Properties
    private let customView = LaundrySymbolsView(frame: UIScreen.main.bounds)
    private let symbolSections = SymbolsSections.getSections()

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }

    // MARK: - Functions
    private func view() -> LaundrySymbolsView {
        return view as! LaundrySymbolsView
    }

    private func setupView() {
        view                             = customView
        view().collectionView.dataSource = self
        view().collectionView.delegate   = self
        navigationItem.title             = NSLocalizedString("Information", comment: "")
    }
}

// MARK: - Delegates
extension LaundrySymbolsViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Identifiers.symbolCellIdentifier, for: indexPath) as? LaundrySymbolsCollectionViewCell {
            let section = symbolSections[indexPath.section]
            cell.laundryImage.image = section.items[indexPath.item].image
            return cell
        }
        return UICollectionViewCell()
    }

    func collectionView(_: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        symbolSections[section].items.count
    }

    func numberOfSections(in _: UICollectionView) -> Int {
        symbolSections.count
    }

    func collectionView(_: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        FeedbackManager.select()
        let sheet = CloAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        present(sheet, animated: true)
        sheet.symbol = symbolSections[indexPath.section].items[indexPath.item]
    }

    func collectionView(_ collectionView: UICollectionView,
                        viewForSupplementaryElementOfKind kind: String,
                        at indexPath: IndexPath) -> UICollectionReusableView {
        if kind == UICollectionView.elementKindSectionHeader {
            if let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: Identifiers.symbolHeaderIdentifier, for: indexPath) as? LaundrySymbolsHeader {
                headerView.headerLabel.text = NSLocalizedString(symbolSections[indexPath.section].title, comment: "")
                return headerView
            }
            return UICollectionReusableView()
        }
        return UICollectionReusableView()
    }

    func collectionView(_ collectionView: UICollectionView, layout _: UICollectionViewLayout, referenceSizeForHeaderInSection _: Int) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: 80.0)
    }
}
