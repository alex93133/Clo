import UIKit

class DetailView: UIView {

    // MARK: - Properties
    var tableView: UITableView!

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupTableView()
        backgroundColor = Colors.whiteColor
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    // MARK: - TableView
    private func setupTableView() {
        tableView                      = UITableView()
        tableView.tableFooterView      = UIView()
        tableView.backgroundColor      = Colors.whiteColor
        tableView.separatorColor       = .clear
        tableView.alwaysBounceVertical = false
        tableView.rowHeight            = UITableView.automaticDimension

        tableView.register(DetailPhotoTableViewCell.self, forCellReuseIdentifier: Identifiers.DetailCells.photoCellIdentifier)
        tableView.register(DetailTypeAndInfoTableViewCell.self, forCellReuseIdentifier: Identifiers.DetailCells.typeWithInfoCellIdentifier)
        tableView.register(DetailSymbolsTableViewCell.self, forCellReuseIdentifier: Identifiers.DetailCells.symbolsCellIdentifier)

        setupTableViewConstraints()
    }
}

// MARK: - Constraints
extension DetailView {

    private func setupTableViewConstraints() {
        addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([tableView.leadingAnchor.constraint(equalTo: leadingAnchor),
                                     tableView.trailingAnchor.constraint(equalTo: trailingAnchor),
                                     tableView.topAnchor.constraint(equalTo: topAnchor),
                                     tableView.bottomAnchor.constraint(equalTo: bottomAnchor)])
    }
}
