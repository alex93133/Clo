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

    override func viewWillAppear(_: Bool) {
        super.viewWillAppear(true)
        tabBarController?.tabBar.barTintColor = Colors.additionalBG
    }

    override func viewDidDisappear(_: Bool) {
        super.viewDidDisappear(true)
        tabBarController?.tabBar.barTintColor = Colors.mainBG
    }

    // MARK: - Functions
    private func view() -> LaundrySymbolsView {
        return view as! LaundrySymbolsView
    }

    private func setupView() {
        view                                             = customView
        view().collectionView.dataSource                 = self
        view().collectionView.delegate                   = self
        navigationItem.title                             = "Information"
        navigationController?.navigationBar.barTintColor = Colors.additionalBG
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
            let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: Identifiers.symbolHeaderIdentifier, for: indexPath) as! LaundrySymbolsHeader
            headerView.headerLabel.text = symbolSections[indexPath.section].title
            return headerView
        }
        return UICollectionReusableView()
    }

    func collectionView(_ collectionView: UICollectionView, layout _: UICollectionViewLayout, referenceSizeForHeaderInSection _: Int) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: 80.0)
    }
}
