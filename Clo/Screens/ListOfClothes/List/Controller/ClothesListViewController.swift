import UIKit

class ClothesListViewController: UIViewController {
    
    // MARK: - Properties
    private let customView = ClothesListView(frame: UIScreen.main.bounds)
    private var clothes: [Clothes]!
    private var visibleClothes: [Clothes]! {
        guard let clothes = clothes else { return []}
        guard let currentCategory = currentCategory else { return clothes }
        let filteredClothes = clothes.filter { $0.type == currentCategory }
        if currentCategory == .all {
            return clothes
        } else {
            return filteredClothes
        }
    }
    
    //    private var index
    private var itemHandler: ((CustomAlertController) -> Void)!
    private var currentCategory: ClothingType!
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        setupView()
        setupNavigationBar()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        clothes = CoreDataManager.shared.fetch { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success:
                self.view().collectionView.reloadData()
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    override func didReceiveMemoryWarning() {
        print("пизда")
    }
    
    // MARK: - Functions
    private func view() -> ClothesListView {
        return view as! ClothesListView
    }
    
    private func setupView() {
        view                             =  customView
        view().collectionView.delegate   = self
        view().collectionView.dataSource = self
        
        itemHandler = { [weak self] sheet in
            guard let self = self else { return }
            self.present(sheet, animated: true)
        }
    }
    
    private func setupNavigationBar() {
        navigationItem.title              = "My clothes"
        let settingsUIBarButtonItem       = UIBarButtonItem(image: Images.settingsIcon, style: .plain, target: self, action: #selector(sortItemPressed))
        settingsUIBarButtonItem.tintColor = Colors.mintColor
        navigationItem.rightBarButtonItem = settingsUIBarButtonItem
    }
    
    private func presentDetailViewController(with clothes: Clothes) {
        let detailViewController = DetailViewController(clothes: clothes)
        navigationController?.pushViewController(detailViewController, animated: true)
    }
    
    private func presentTypeSheet() {
        let typeViewController  = TypeViewController()
        let sheetViewController = AddEditClothesViewController.createTypeSheet(typeViewController: typeViewController)
        
        let category = currentCategory ?? .all
        typeViewController.selectedType = category
        
        present(sheetViewController, animated: false)
        
        typeViewController.selectedTypeHandle = { [weak self] type in
            guard let self = self else { return }
            self.currentCategory = type
            self.view().collectionView.reloadData()
            sheetViewController.closeSheet()
        }
    }
}

// MARK: - Delegates
extension ClothesListViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        visibleClothes.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if  let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Identifiers.clothesCellIdentifier, for: indexPath) as? ClothesListCollectionViewCell {
            let currentClothes          = visibleClothes[indexPath.item]
            cell.clothesImageView.image = currentClothes.photo
            cell.symbols                = currentClothes.symbols
            cell.color                  = currentClothes.color
            cell.itemHandler            = itemHandler
            return cell
        }
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let selectedClothes = visibleClothes[indexPath.item]
        presentDetailViewController(with: selectedClothes)
    }
}

// MARK: - Actions
extension ClothesListViewController {
    
    @objc func sortItemPressed() {
        presentTypeSheet()
    }
}
