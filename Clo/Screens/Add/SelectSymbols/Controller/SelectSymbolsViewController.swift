import UIKit

class SelectSymbolsViewController: UIViewController {

    // MARK: - Properties
    private let customView = SelectSymbolsView(frame: UIScreen.main.bounds)
    var clothesInfo: (type: ClothingType, color: ColorType, info: String?, photo: UIImage)!
    private let selectionSectionTitle = "Your choice"
    private var sections = SymbolsSections.getSections()
    private var visibleSections: [SymbolsSections] {
        return sections.filter { !$0.hidden }
    }
    private var selectedSymbols = [Symbol]() {
        willSet {
            if newValue.count == 0 {
                showHideSelectionSection(show: false)
                view().nextButton.enableButton(isOn: false, minAlphaValue: 0)
            }
        }
        didSet {
            if oldValue.count == 0 {
                showHideSelectionSection(show: true)
                view().nextButton.enableButton(isOn: true)
            }
        }
    }

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }

    // MARK: - Functions
    private func view() -> SelectSymbolsView {
        return view as! SelectSymbolsView
    }

    private func setupView() {
        view  =  customView
        view().laundrySymbolsView.collectionView.dataSource = self
        view().laundrySymbolsView.collectionView.delegate = self
        view().nextButton.enableButton(isOn: false, minAlphaValue: 0)
        view().nextButtonHandler = { [unowned self] in
            self.presentTabBarController()
        }
        createSelectedSymbolsSection()
    }

    private func createSelectedSymbolsSection() {
        let section = SymbolsSections(title: selectionSectionTitle, items: [])
        sections.insert(section, at: 0)
    }

    private func addItem(item: Symbol) {
        selectedSymbols.append(item)
        sections[0].items = selectedSymbols
    }

    private func removeItem(index: Int) {
        selectedSymbols.remove(at: index)
        sections[0].items = selectedSymbols
    }

    private func showHideSelectionSection(show: Bool) {
        sections[0].hidden = !show
        view().laundrySymbolsView.collectionView.reloadData()
    }

    private func showHideCategory(category: Categories, show: Bool) {
        if let index = sections.firstIndex(where: { $0.title == category.rawValue }) {
            sections[index].hidden = !show
            view().laundrySymbolsView.collectionView.reloadData()
        }
    }

    private func saveClothes() {
        let clothes = Clothes(type: clothesInfo.type,
                              color: clothesInfo.color,
                              info: clothesInfo.info,
                              photo: clothesInfo.photo,
                              symbols: selectedSymbols)
        CoreDataManager.shared.saveData(clothes: clothes)
    }

    private func presentTabBarController() {
        saveClothes()
        let tabBraController = TabBarController()
        tabBraController.modalPresentationStyle = .fullScreen
        present(tabBraController, animated: true)
    }
}

// MARK: - Delegates
extension SelectSymbolsViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Identifiers.symbolCellIdentifier, for: indexPath) as! LaundrySymbolsCollectionViewCell

        let section = visibleSections[indexPath.section]
        cell.laundryImage.image = section.items[indexPath.item].image?.withRenderingMode(.alwaysTemplate)

        if section.title == selectionSectionTitle {
            cell.laundryImage.tintColor = Colors.mintColor
        } else {
            cell.laundryImage.tintColor = .black
        }
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        visibleSections[section].items.count
    }

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        visibleSections.count
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let item = visibleSections[indexPath.section].items[indexPath.item]

        if visibleSections[indexPath.section].title == selectionSectionTitle {
            removeItem(index: indexPath.item)
            showHideCategory(category: item.category, show: true)
        } else {
            addItem(item: item)
            showHideCategory(category: item.category, show: false)
        }
    }

    func collectionView(_ collectionView: UICollectionView,
                        viewForSupplementaryElementOfKind kind: String,
                        at indexPath: IndexPath) -> UICollectionReusableView {
        if kind == UICollectionView.elementKindSectionHeader {
            let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: Identifiers.symbolHeaderIdentifier, for: indexPath) as! LaundrySymbolsHeader
            headerView.headerLabel.text = visibleSections[indexPath.section].title
            return headerView
        }
        return UICollectionReusableView()
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: 32.0)
    }
}
