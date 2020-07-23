import CoreData
import UIKit

class ClothesListViewController: UIViewController, UIGestureRecognizerDelegate {

    // MARK: - Properties
    private let customView = ClothesListView(frame: UIScreen.main.bounds)
    private var washingFilterSheet: WashingFilterSheet!
    private var itemHandler: ((CloAlertController) -> Void)!
    private var currentCategory: ClothingType!
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
    var presentPhotoSheet: (() -> Void)!

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        gestureRecognizer()
    }

    override func viewWillAppear(_: Bool) {
        super.viewWillAppear(true)
        setupNavigationBar()
        getClothes()
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

    private func gestureRecognizer() {
        let longPress: UILongPressGestureRecognizer = UILongPressGestureRecognizer(target: self,
                                                                                   action: #selector(handleLongPress(gesture:)))
        longPress.minimumPressDuration              = 0.6
        longPress.delegate                          = self
        longPress.delaysTouchesBegan                = false
        view().collectionView.addGestureRecognizer(longPress)
    }

    private func getClothes() {
        clothes = CoreDataManager.shared.fetchClothes { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success:
                self.view().collectionView.reloadData()

            case let .failure(error):
                print(error.localizedDescription)
            }
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
        let settingsUIBarButtonItem = UIBarButtonItem(image: Images.settingsIcon,
                                                      style: .plain,
                                                      target: self,
                                                      action: #selector(sortItemPressed))
        settingsUIBarButtonItem.tintColor = Colors.mint
        navigationItem.rightBarButtonItem = settingsUIBarButtonItem
        navigationItem.title              = NSLocalizedString("My clothes", comment: "")
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

    private func presentWashingFilter(with clothes: Clothes?) {
        washingFilterSheet = WashingFilterSheet()
        if let clothes = clothes {
            if clothes.symbols.contains(where: { $0.id ==  4 }) {
                guard let symbol = clothes.symbols.first(where: { $0.id ==  4 }) else { return }
                WashingManager.presentViewWithWarning(symbol: symbol, target: self)
            }
            if clothes.symbols.contains(where: { $0.id ==  5 }) {
                guard let symbol = clothes.symbols.first(where: { $0.id ==  5 }) else { return }
                WashingManager.presentViewWithError(symbol: symbol, target: self)
            }
        }
        washingFilterSheet.washingFilter.referenceClothes = clothes
        present(washingFilterSheet.sheet, animated: false)
    }

    // MARK: - Actions
    @objc
    func sortItemPressed() {
        presentTypeSheet()
    }

    @objc
    func handleLongPress(gesture: UILongPressGestureRecognizer!) {
        guard gesture.state == .began else { return }
        FeedbackManager.heavy()
        let point = gesture.location(in: view().collectionView)
        if let indexPath = view().collectionView.indexPathForItem(at: point) {
            presentWashingFilter(with: visibleClothes[indexPath.item])
        }
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
                cell.addLabel.text         = NSLocalizedString("Add new item", comment: "")
                cell.backgroundImage.image = Images.AddNewItem
                return cell
            }
        } else {
            if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Identifiers.clothesCellIdentifier, for: indexPath) as? ClothesListCollectionViewCell {
                let currentClothes          = visibleClothes[indexPath.item]
                cell.clothesImageView.image = currentClothes.photo
                cell.symbols                = currentClothes.symbols
                cell.color                  = currentClothes.color
                cell.itemHandler            = itemHandler
                return cell
            }
        }
        return UICollectionViewCell()
    }

    func collectionView(_: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if visibleClothes.isEmpty {
            presentPhotoSheet()
        } else {
            let selectedClothes = visibleClothes[indexPath.item]
            presentDetailViewController(with: selectedClothes)
        }
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        guard let layout = collectionViewLayout as? UICollectionViewFlowLayout else { return CGSize() }
        let itemWidth: CGFloat = view.frame.size.width - layout.sectionInset.left - layout.sectionInset.right
        let itemHeight: CGFloat = visibleClothes.isEmpty && clothes.isEmpty ? 78 : itemWidth / 1.3
        return CGSize(width: itemWidth, height: itemHeight)
    }
}

extension ClothesListViewController: ItemViewControllerDelegate {
    func applySelectedItem(with item: String) {
        guard let category = ClothingType(rawValue: item) else { return }
        currentCategory = category
        smoothReloadData()
    }
}
