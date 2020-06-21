import UIKit

class ItemView: UIView {

    // MARK: - Properties
    var tableView: UITableView!

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupTableView()
        backgroundColor = Colors.mainBG
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    // MARK: - TableView
    private func setupTableView() {
        tableView                      = UITableView()
        tableView.tableFooterView      = UIView()
        tableView.backgroundColor      = Colors.mainBG
        tableView.separatorColor       = Colors.border
        tableView.alwaysBounceVertical = false
        tableView.register(ItemTableViewCell.self, forCellReuseIdentifier: Identifiers.colorTypeCellIdentifier)

        setupTableViewConstraints()
    }

    // MARK: - Constraints
    private func setupTableViewConstraints() {
        addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            tableView.leadingAnchor.constraint(equalTo: leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: trailingAnchor),
            tableView.topAnchor.constraint(equalTo: topAnchor),
            tableView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
}
