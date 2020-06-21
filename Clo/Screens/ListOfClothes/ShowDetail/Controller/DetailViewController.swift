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
        navigationItem.title              = "About"
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

        let editAction = UIAlertAction(title: "Edit", style: .default) { [weak self] _ in
            guard let self = self else { return }
            let editViewController = AddEditClothesViewController(clothes: self.clothes)
            self.navigationController?.pushViewController(editViewController, animated: true)
        }
        let deleteAction = UIAlertAction(title: "Delete", style: .destructive) { [weak self] _ in
            guard let self = self else { return }
            self.deleteClothes()
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)

        deleteAction.setValue(Images.deleteIcon, forKey: "image")
        editAction.setValue(Images.editIcon, forKey: "image")

        alertController.addAction(editAction)
        alertController.addAction(deleteAction)
        alertController.addAction(cancelAction)
    }

    private func deleteClothes() {
        CoreDataManager.shared.delete(clothes: clothes) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success:
                self.navigationController?.popViewController(animated: true)

            case let .failure(error):
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
            if let cell = tableView.dequeueReusableCell(withIdentifier: Identifiers.DetailCells.typeWithInfoCellIdentifier) as? DetailTypeAndInfoTableViewCell {
                cell.typeLabel.text = clothes.type.rawValue
                if let info = clothes.info {
                    cell.infoLabel.text = info
                } else {
                    cell.infoLabel.isHidden = true
                }
                return cell
            }

        case 2:
            if let cell = tableView.dequeueReusableCell(withIdentifier: Identifiers.DetailCells.symbolsCellIdentifier) as? DetailSymbolsTableViewCell {
                if indexPath.row == 0 {
                    let insets = UIEdgeInsets(top: 6, left: 6, bottom: 6, right: 6)
                    cell.symbolImageView.image = UIImage(named: clothes.color.rawValue)?.withAlignmentRectInsets(insets)
                    cell.descriptionLabel.text = clothes.color.rawValue
                } else {
                    let symbol = clothes.symbols[indexPath.row - 1]
                    cell.descriptionLabel.text = symbol.description
                    cell.symbolImageView.image = symbol.image?.withRenderingMode(.alwaysTemplate)
                }
                return cell
            }

        default:
            fatalError("There are no cell")
        }
        return UITableViewCell()
    }
}
