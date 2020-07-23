import UIKit

class LaundryListViewController: UIViewController {

    // MARK: - Properties
    private let customView = LaundryListView(frame: UIScreen.main.bounds)
    private var laundries = [Laundry]()

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        getLaundries()
    }

    // MARK: - Functions
    private func view() -> LaundryListView {
        return view as! LaundryListView
    }

    private func setupView() {
        view                             = customView
        view().collectionView.delegate   = self
        view().collectionView.dataSource = self
        navigationItem.title = NSLocalizedString("Laundry", comment: "")
    }

    private func getLaundries() {
        laundries = CoreDataManager.shared.fetchLaundries { [weak self] result in
            guard let self = self else { return }

            switch result {
            case .success:
                self.view().collectionView.reloadData()

            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }

    private func presentDetail(laundry: Laundry) {
        let laundryDetailViewController = LaundryDetailViewController(laundry: laundry)
        navigationController?.pushViewController(laundryDetailViewController, animated: true)
    }

    private func presentNewLaundry() {
        let newLaundryViewController = NewLaundryViewController()
        newLaundryViewController.hidesBottomBarWhenPushed = true
        navigationController?.pushViewController(newLaundryViewController, animated: true)
    }
}

// MARK: - Delegates
extension LaundryListViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return laundries.isEmpty ? 1 : laundries.count + 1
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch indexPath.item {
        case 0:
            if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Identifiers.newLaundryCellIdentifier, for: indexPath) as? NewLaundryCollectionViewCell {
                return cell
            }

        default:
            guard !laundries.isEmpty else { return UICollectionViewCell() }
            if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Identifiers.laundryCellIdentifier, for: indexPath) as? LaundryListCollectionViewCell {
                let laundry                = laundries[indexPath.item - 1]
                cell.laundryNameLabel.text = laundry.name
                cell.laundry               = laundry
                cell.itemSelected = { [weak self] in
                    guard let self = self else { return } 
                    self.presentDetail(laundry: laundry)
                }
                return cell
            }
        }
        return UICollectionViewCell()
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        switch indexPath.item {
        case 0:
            presentNewLaundry()

        default:
            let laundry = laundries[indexPath.item - 1]
            presentDetail(laundry: laundry)
        }
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        guard let layout = collectionViewLayout as? UICollectionViewFlowLayout else { return CGSize() }
        let itemWidth: CGFloat = view.frame.size.width - layout.sectionInset.left - layout.sectionInset.right
        let itemHeight: CGFloat = indexPath.item == 0 ? 78 : 66
        return CGSize(width: itemWidth, height: itemHeight)
    }
}
