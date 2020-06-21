import CoreData
import UIKit

protocol ClothesListViewControllerDelegate: class {
    func presentPhotoSheet()
}

class ClothesListViewController: UIViewController {

    // MARK: - Properties
    private let customView = ClothesListView(frame: UIScreen.main.bounds)
    private var itemHandler: ((CloAlertController) -> Void)!
    private var currentCategory: ClothingType!
    weak var delegate: ClothesListViewControllerDelegate!
    private var clothes: [Clothes]!
    private var visibleClothes: [Clothes]! {
        guard let clothes = clothes else { return [] }
        guard let currentCategory = currentCategory else { return clothes }
        let filteredClothes = clothes.filter { $0.type == currentCategory }
        if currentCategory == .all {
            return clothes
        } else {
            return filteredClothes
        }
    }

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupNavigationBar()
    }

    override func viewWillAppear(_: Bool) {
        super.viewWillAppear(true)
        clothes = CoreDataManager.shared.fetch { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success:
                self.view().collectionView.reloadData()

            case let .failure(error):
                print(error.localizedDescription)
            }
        }
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

    private func smoothReloadData() {
        UIView.transition(with: view().collectionView,
                          duration: Constants.animationTimeInterval,
                          options: .transitionCrossDissolve,
                          animations: { [weak self] in self?.view().collectionView.reloadData() },
                          completion: nil)
    }

    private func setupNavigationBar() {
        navigationItem.title = "My clothes"
        let settingsUIBarButtonItem = UIBarButtonItem(image: Images.settingsIcon, style: .plain, target: self, action: #selector(sortItemPressed))
        settingsUIBarButtonItem.tintColor = Colors.mint
        navigationItem.rightBarButtonItem = settingsUIBarButtonItem
    }

    private func presentDetailViewController(with clothes: Clothes) {
        let detailViewController = DetailViewController(clothes: clothes)
        detailViewController.hidesBottomBarWhenPushed = true
        navigationController?.pushViewController(detailViewController, animated: true)
    }

    private func presentTypeSheet() {
        let clothesTypes                          = ClothingType.allCases.map { $0.rawValue }
        let typeSheet                             = ItemSheet(items: clothesTypes)
        let category                              = currentCategory ?? .all
        typeSheet.itemViewController.selectedItem = category.rawValue
        typeSheet.itemViewController.delegate     = self
        present(typeSheet.sheet, animated: false)
    }

    // MARK: - Actions
    @objc
    func sortItemPressed() {
        presentTypeSheet()
    }
}

// MARK: - Delegates
extension ClothesListViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_: UICollectionView, numberOfItemsInSection _: Int) -> Int {
        if visibleClothes.isEmpty, clothes.isEmpty {
            return 1
        } else {
            return visibleClothes.count
        }
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if clothes.isEmpty {
            if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Identifiers.addNewItemCellIdentifier, for: indexPath) as? AddNewItemCollectionViewCell {
                return cell
            }
        } else {
            if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Identifiers.clothesCellIdentifier, for: indexPath) as? ClothesListCollectionViewCell {
                let currentClothes = visibleClothes[indexPath.item]
                cell.clothesImageView.image = currentClothes.photo
                cell.symbols = currentClothes.symbols
                cell.color = currentClothes.color
                cell.itemHandler = itemHandler
                return cell
            }
        }
        return UICollectionViewCell()
    }

    func collectionView(_: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if visibleClothes.isEmpty {
            delegate.presentPhotoSheet()
        } else {
            let selectedClothes = visibleClothes[indexPath.item]
            presentDetailViewController(with: selectedClothes)
        }
    }
}

extension ClothesListViewController: ItemViewControllerDelegate {
    func applySelectedItem(with item: String) {
        guard let category = ClothingType(rawValue: item) else { return }
        currentCategory = category
        smoothReloadData()
    }
}
