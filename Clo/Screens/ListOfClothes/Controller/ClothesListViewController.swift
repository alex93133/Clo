import UIKit

class ClothesListViewController: UIViewController {
    
    // MARK: - Properties
    private let customView = ClothesListView(frame: UIScreen.main.bounds)
    
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
        3
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if  let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Identifiers.clothesCellIdentifier, for: indexPath) as? ClothesListCollectionViewCell {
            cell.clothesImageView.image = UIImage(named: "EXAMPLE")
            cell.clothesName.text = "Pullover"
            return cell
        }
        return UICollectionViewCell()
    }
}

// MARK: - Actions
extension ClothesListViewController {
    
    @objc func settingsItemPressed() {
        print("Om")
    }
}
