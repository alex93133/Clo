import UIKit
import FittedSheets

class LaundrySymbolsViewController: UIViewController {

    // MARK: - Properties
    let customView = LaundrySymbolsView(frame: UIScreen.main.bounds)
    let symbolSections = SymbolsSections.getSections()
    var symbolDescriptionViewController: SymbolDescriptionViewController!

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

    fileprivate func setupPhotoSheet() -> SheetViewController {
        symbolDescriptionViewController    = SymbolDescriptionViewController()
        let height: CGFloat                = 220
        let sheet                          = SheetViewController(controller: symbolDescriptionViewController, sizes: [.fixed(height)])
        sheet.extendBackgroundBehindHandle = true
        sheet.adjustForBottomSafeArea      = true
        sheet.topCornersRadius             = 15
        sheet.overlayColor                 = .clear
        return sheet
    }
}

// MARK: - CollectionViewDelegates
extension LaundrySymbolsViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Constants.symbolCellIdentifier, for: indexPath) as! LaundrySymbolsCollectionViewCell

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
        if let cell = collectionView.cellForItem(at: indexPath)  as? LaundrySymbolsCollectionViewCell {

            let sheetViewController = setupPhotoSheet()
            let selectedSymbol      = symbolSections[indexPath.section].items[indexPath.item]

            symbolDescriptionViewController.passedImage = selectedSymbol.image
            symbolDescriptionViewController.passedDescription = selectedSymbol.description

            present(sheetViewController, animated: true)

            sheetViewController.didDismiss = { _ in
                cell.isSelected = false
            }
        }
    }

    func collectionView(_ collectionView: UICollectionView,
                        viewForSupplementaryElementOfKind kind: String,
                        at indexPath: IndexPath) -> UICollectionReusableView {
        if kind == UICollectionView.elementKindSectionHeader {
            let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: Constants.symbolHeaderIdentifier, for: indexPath) as! LaundrySymbolsHeader
            headerView.headerLabel.text = symbolSections[indexPath.section].title
            return headerView
        }
        return UICollectionReusableView()
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: 80.0)
    }
}
