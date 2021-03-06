import UIKit

class DetailViewController: UIViewController {

    // MARK: - Properties
    private let customView = DetailView(frame: UIScreen.main.bounds)
    private var alertController: UIAlertController!
    var clothes: Clothes

    init(clothes: Clothes) {
        self.clothes = clothes
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupNavigationBar()
        createActionSheet()
    }

    // MARK: - Functions
    private func view() -> DetailView {
        return view as! DetailView
    }

    private func setupView() {
        view                        = customView
        view().tableView.delegate   = self
        view().tableView.dataSource = self
    }

    private func setupNavigationBar() {
        navigationItem.title              = NSLocalizedString("About", comment: "")
        let settingsUIBarButtonItem       = UIBarButtonItem(image: Images.editIcon,
                                                            style: .plain,
                                                            target: self,
                                                            action: #selector(editButtonPressed))
        settingsUIBarButtonItem.tintColor = Colors.mint
        navigationItem.rightBarButtonItem = settingsUIBarButtonItem
    }

    private func createActionSheet() {
        alertController = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        alertController.view.tintColor = Colors.mint

        let editAction = UIAlertAction(title: NSLocalizedString("Edit", comment: ""), style: .default) { [weak self] _ in
            guard let self = self else { return }
            let editViewController = AddEditClothesViewController(clothes: self.clothes)
            self.navigationController?.pushViewController(editViewController, animated: true)
        }
        let deleteAction = UIAlertAction(title: NSLocalizedString("Delete", comment: ""), style: .destructive) { [weak self] _ in
            guard let self = self else { return }
            self.deleteClothes()
        }
        let cancelAction = UIAlertAction(title: NSLocalizedString("Cancel", comment: ""), style: .cancel)

        deleteAction.setValue(Images.deleteIcon, forKey: "image")
        editAction.setValue(Images.editIcon, forKey: "image")

        alertController.addAction(editAction)
        alertController.addAction(deleteAction)
        alertController.addAction(cancelAction)
    }

    private func deleteClothes() {
        CoreDataManager.shared.deleteClothes(clothes: clothes) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success:
                FeedbackManager.success()
                self.navigationController?.popViewController(animated: true)

            case let .failure(error):
                FeedbackManager.error()
                print(error.localizedDescription)
            }
        }
    }

    // MARK: - Actions
    @objc
    private func editButtonPressed() {
        present(alertController, animated: true)
    }
}

// MARK: - Delegates
extension DetailViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in _: UITableView) -> Int {
        3
    }

    func tableView(_: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 2:
            return clothes.symbols.count + 1

        default:
            return 1
        }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            if let cell = tableView.dequeueReusableCell(withIdentifier: Identifiers.DetailCells.photoCellIdentifier) as? DetailPhotoTableViewCell {
                cell.photoImageView.image = clothes.photo
                return cell
            }

        case 1:
            if let cell = tableView.dequeueReusableCell(withIdentifier: Identifiers.DetailCells.typeWithInfoCellIdentifier,
                                                        for: indexPath) as? DetailTypeAndInfoTableViewCell {
                cell.typeLabel.text = NSLocalizedString(clothes.type.rawValue, comment: "")
                if let info = clothes.info {
                    cell.infoLabel.text = info
                } else {
                    cell.infoLabel.isHidden = true
                }
                return cell
            }

        case 2:
            if let cell = tableView.dequeueReusableCell(withIdentifier: Identifiers.DetailCells.symbolsCellIdentifier,
                                                        for: indexPath) as? DetailSymbolsTableViewCell {
                if indexPath.row == 0 {
                    let insets = UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
                    cell.symbolImageView.image = UIImage(named: clothes.color.rawValue)?.withAlignmentRectInsets(insets)
                    cell.descriptionLabel.text = NSLocalizedString(clothes.color.rawValue, comment: "")
                } else {
                    let symbol = clothes.symbols[indexPath.row - 1]
                    cell.descriptionLabel.text = NSLocalizedString(symbol.description, comment: "")
                    cell.symbolImageView.image = symbol.image
                }
                return cell
            }

        default:
            fatalError("There are no cell")
        }
        return UITableViewCell()
    }
}
