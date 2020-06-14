import UIKit

class SelectSymbolsViewController: UIViewController {
    
    // MARK: - Properties
    private let customView = SelectSymbolsView(frame: UIScreen.main.bounds)
    var clothesInfo: (type: ClothingType, color: ColorType, info: String?, photo: UIImage)!
    var editableClothes: Clothes?
    private let selectionSectionTitle = "Your choice"
    private var sections = SymbolsSections.getSections().sorted { $0.index < $1.index }
    private var selectedSymbols = [Symbol]() {
        willSet {
            if newValue.count == 0 {
                view().nextButton.enableButton(isOn: false, minAlphaValue: 0)
            } else {
                view().nextButton.enableButton(isOn: true)
            }
        }
    }
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupNavigationBar()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        hideCategoriesWhenAppear()
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
        view().nextButtonHandler = { [weak self] in
            guard let self = self else { return }
            self.handleData()
        }
        createSelectedSymbolsSection()
    }
    
    private func setupNavigationBar() {
           let title            = editableClothes == nil ? "Add your icons" : "Edit your icons"
           navigationItem.title = title
       }
    
    private func createSelectedSymbolsSection() {
        let items = editableClothes?.symbols ?? []
        let section = SymbolsSections(index: 0, title: selectionSectionTitle, category: nil, items: items)
        sections.insert(section, at: 0)
    }
    
    private func hideCategoriesWhenAppear() {
        guard let editableClothes = editableClothes else { return }
        selectedSymbols = editableClothes.symbols
        let categories = editableClothes.symbols.map { $0.category }
        
        for category in categories {
            if let index = sections.firstIndex(where: { category == $0.category }) {
                sections.remove(at: index)
            }
        }
    }
    
    private func selectItem(indexPath: IndexPath) {
        let item = sections[indexPath.section].items[indexPath.item]
        selectedSymbols.append(item)
        sections[0].items.append(item)
        view().laundrySymbolsView.collectionView.reloadSections(IndexSet(arrayLiteral: 0))
        removeSection(indexPath: indexPath)
    }
    
    private func removeSection(indexPath: IndexPath) {
        sections.remove(at: indexPath.section)
        let indexSet = IndexSet(arrayLiteral: indexPath.section)
        view().laundrySymbolsView.collectionView.deleteSections(indexSet)
    }
    
    
    private func unselectItem(indexPath: IndexPath) {
        restoreSection(indexPath: indexPath)
        let itemID = sections[indexPath.section].items[indexPath.item].id
        selectedSymbols.removeAll { $0.id == itemID }
        sections[0].items.remove(at: indexPath.item)
        view().laundrySymbolsView.collectionView.deleteItems(at: [indexPath])
    }
    
    private func restoreSection(indexPath: IndexPath) {
        let category = sections[indexPath.section].items[indexPath.item].category
        let allSections = SymbolsSections.getSections()
        
        guard let section = allSections.first(where: { $0.category == category }) else { return }
        sections.append(section)
        sections.sort { $0.index < $1.index }
        
        guard let index = sections.firstIndex(where: { $0.category == category }) else {return}
        let indexSet = IndexSet(arrayLiteral: index)
        view().laundrySymbolsView.collectionView.insertSections(indexSet)
    }
    
    private func handleData() {
        if editableClothes != nil {
            updateClothes()
        } else {
            saveClothes()
        }
    }
    
    private func saveClothes() {
        let clothes = Clothes(uID: UUID().uuidString,
                              type: clothesInfo.type,
                              color: clothesInfo.color,
                              info: clothesInfo.info,
                              photo: clothesInfo.photo,
                              symbols: selectedSymbols)
        CoreDataManager.shared.saveData(clothes: clothes) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success:
                self.presentTabBarController()
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    private func updateClothes() {
        guard var editableClothes = editableClothes else { return }
        editableClothes.photo = clothesInfo.photo
        editableClothes.type = clothesInfo.type
        editableClothes.color = clothesInfo.color
        editableClothes.info = clothesInfo.info
        editableClothes.symbols = selectedSymbols
        
        CoreDataManager.shared.update(editableClothes: editableClothes) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success:
                self.presentTabBarController()
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    private func presentTabBarController() {
        let tabBraController = TabBarController()
        tabBraController.modalPresentationStyle = .fullScreen
        present(tabBraController, animated: true)
    }
}

// MARK: - Delegates
extension SelectSymbolsViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        collectionView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 50, right: 0)
        
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Identifiers.symbolCellIdentifier, for: indexPath) as? LaundrySymbolsCollectionViewCell {
            let section = sections[indexPath.section]
            cell.laundryImage.image = section.items[indexPath.item].image?.withRenderingMode(.alwaysTemplate)
            
            if section.title == selectionSectionTitle {
                cell.laundryImage.tintColor = Colors.mintColor
            } else {
                cell.laundryImage.tintColor = .black
            }
            return cell
        }
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        sections[section].items.count
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        sections.count
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if indexPath.section != 0 {
            selectItem(indexPath: indexPath)
        } else {
            unselectItem(indexPath: indexPath)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        viewForSupplementaryElementOfKind kind: String,
                        at indexPath: IndexPath) -> UICollectionReusableView {
        if kind == UICollectionView.elementKindSectionHeader {
            let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: Identifiers.symbolHeaderIdentifier, for: indexPath) as! LaundrySymbolsHeader
            headerView.headerLabel.text = sections[indexPath.section].title
            return headerView
        }
        return UICollectionReusableView()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: 32.0)
    }
}
