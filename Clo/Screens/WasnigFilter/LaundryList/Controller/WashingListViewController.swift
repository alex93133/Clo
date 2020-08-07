import UIKit

class WashingListViewController: UIViewController {

    // MARK: - Properties
    private let customView = WashingListView(frame: UIScreen.main.bounds)
    private var washing = [Washing]()

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        getWashing()
    }

    // MARK: - Functions
    private func view() -> WashingListView {
        return view as! WashingListView
    }

    private func setupView() {
        view                             = customView
        view().collectionView.delegate   = self
        view().collectionView.dataSource = self
        navigationItem.title = NSLocalizedString("Washing", comment: "")
    }

    private func getWashing() {
        washing = CoreDataManager.shared.fetchWashing { [weak self] result in
            guard let self = self else { return }

            switch result {
            case .success:
                self.view().collectionView.reloadData()

            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }

    private func presentDetail(washing: Washing) {
        let washingDetailViewController = WashingDetailViewController(washing: washing)
        navigationController?.pushViewController(washingDetailViewController, animated: true)
    }

    private func presentNewWashing() {
        let newWashingViewController = NewWashingViewController()
        newWashingViewController.hidesBottomBarWhenPushed = true
        navigationController?.pushViewController(newWashingViewController, animated: true)
    }
}

// MARK: - Delegates
extension WashingListViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return washing.isEmpty ? 1 : washing.count + 1
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch indexPath.item {
        case 0:
            if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Identifiers.addNewItemCellIdentifier,
                                                             for: indexPath) as? AddNewItemCollectionViewCell {
                cell.addLabel.text         = NSLocalizedString("Collect the wash", comment: "")
                cell.backgroundImage.image = Images.addNewWashing
                return cell
            }

        default:
            guard !washing.isEmpty else { return UICollectionViewCell() }
            if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Identifiers.washingCellIdentifier,
                                                             for: indexPath) as? WashingListCollectionViewCell {
                let currentWashing         = washing[indexPath.item - 1]
                cell.washingNameLabel.text = NSLocalizedString(currentWashing.name, comment: "")
                cell.washing               = currentWashing
                cell.itemSelected = { [weak self] in
                    guard let self = self else { return }
                    self.presentDetail(washing: currentWashing)
                }
                return cell
            }
        }
        return UICollectionViewCell()
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        switch indexPath.item {
        case 0:
            presentNewWashing()

        default:
            let currentWashing = washing[indexPath.item - 1]
            presentDetail(washing: currentWashing)
        }
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        guard let layout = collectionViewLayout as? UICollectionViewFlowLayout else { return CGSize() }
        let itemWidth: CGFloat = view.frame.size.width - layout.sectionInset.left - layout.sectionInset.right
        let itemHeight: CGFloat = indexPath.item == 0 ? 78 : 66
        return CGSize(width: itemWidth, height: itemHeight)
    }
}
