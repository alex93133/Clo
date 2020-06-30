import UIKit

class ResultViewController: UIViewController {

    // MARK: - Properties
    private let customView = ClothesListView(frame: UIScreen.main.bounds)
    private var itemHandler: ((CloAlertController) -> Void)!
    var clothes: [Clothes]?

    init(clothes: [Clothes]?) {
        self.clothes = clothes
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupNavigationBar()
    }

    // MARK: - Functions
    private func view() -> ClothesListView {
        return view as! ClothesListView
    }

    private func setupView() {
        view                             = customView
        view().collectionView.delegate   = self
        view().collectionView.dataSource = self

        itemHandler = { [weak self] sheet in
            guard let self = self else { return }
            self.present(sheet, animated: true)
        }
    }

    private func setupNavigationBar() {
        navigationItem.title             = NSLocalizedString("Your laundry", comment: "")
        let backUIBarButtonItem          = UIBarButtonItem(image: Images.crossIcon,
                                                           style: .plain,
                                                           target: self,
                                                           action: #selector(backButtonPressed))
        backUIBarButtonItem.tintColor    = Colors.mint
        navigationItem.leftBarButtonItem = backUIBarButtonItem
    }

    @objc
    private func backButtonPressed() {
        dismiss(animated: true)
    }
}

extension ResultViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        clothes?.count ?? 0
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Identifiers.clothesCellIdentifier, for: indexPath) as? ClothesListCollectionViewCell {
            guard let clothes = clothes else { return UICollectionViewCell() }
            let currentClothes          = clothes[indexPath.item]
            cell.clothesImageView.image = currentClothes.photo
            cell.symbols                = currentClothes.symbols
            cell.color                  = currentClothes.color
            cell.itemHandler            = itemHandler
            return cell
        }
        return UICollectionViewCell()
    }
}
