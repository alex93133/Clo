import UIKit

class ClothesListViewController: UIViewController {

    // MARK: - Properties
    private let customView = ClothesListView(frame: UIScreen.main.bounds)
    private var clothes = CoreDataManager.shared.fetch() {
        didSet {
            view().collectionView.reloadData()
        }
    }

    // MARK: - Lifecycle
    override func viewDidLoad() {
        setupView()
        setupNavigationBar()
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
}

// MARK: - Delegates
extension ClothesListViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        clothes.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if  let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Identifiers.clothesCellIdentifier, for: indexPath) as? ClothesListCollectionViewCell {
            cell.clothesImageView.image = clothes[indexPath.item].photo
            cell.symbols = clothes[indexPath.item].symbols
            return cell
        }
        return UICollectionViewCell()
    }
}

// MARK: - Actions
extension ClothesListViewController {

    @objc func settingsItemPressed() {
        CoreDataManager.shared.delete { [unowned self] result in
            switch result {
            case .success:
                self.clothes = [Clothes]()
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}
