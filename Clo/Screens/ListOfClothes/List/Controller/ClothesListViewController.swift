import UIKit

class ClothesListViewController: UIViewController {

    // MARK: - Properties
    private let customView = ClothesListView(frame: UIScreen.main.bounds)
    private var clothes: [Clothes]!

    // MARK: - Lifecycle
    override func viewDidLoad() {
        setupView()
        setupNavigationBar()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        clothes = CoreDataManager.shared.fetch { [unowned self] result in
            switch result {
            case .success:
                self.view().collectionView.reloadData()
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }

    // MARK: - Functions
    private func view() -> ClothesListView {
        return view as! ClothesListView
    }

    private func setupView() {
        view                             =  customView
        view().collectionView.delegate   = self
        view().collectionView.dataSource = self
    }

    private func setupNavigationBar() {
        navigationItem.title = "My clothes"
        let settingsUIBarButtonItem = UIBarButtonItem(image: Images.settingsIcon, style: .plain, target: self, action: #selector(settingsItemPressed))
        settingsUIBarButtonItem.tintColor = Colors.mintColor
        navigationItem.rightBarButtonItem  = settingsUIBarButtonItem
    }
    
    private func presentDetailViewController(with clothes: Clothes) {
        let detailViewController = DetailViewController(clothes: clothes)
        navigationController?.pushViewController(detailViewController, animated: true)
    }
}

// MARK: - Delegates
extension ClothesListViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        clothes.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if  let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Identifiers.clothesCellIdentifier, for: indexPath) as? ClothesListCollectionViewCell {
            let currentClothes          = clothes[indexPath.item]
            cell.clothesImageView.image = currentClothes.photo
            cell.symbols                = currentClothes.symbols
            cell.color                  = currentClothes.color
            return cell
        }
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let selectedClothes = clothes[indexPath.item]
        presentDetailViewController(with: selectedClothes)
    }
}

// MARK: - Actions
extension ClothesListViewController {

    @objc func settingsItemPressed() {
       
    }
}
