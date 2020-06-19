import UIKit

class TypeView: UIView {

    // MARK: - Properties
    var tableView: UITableView!

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupTableView()
        backgroundColor = Colors.whiteBGColor
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    // MARK: - TableView
    private func setupTableView() {
        tableView                      = UITableView()
        tableView.tableFooterView      = UIView()
        tableView.backgroundColor      = Colors.whiteBGColor
        tableView.separatorColor       = Colors.separator
        tableView.alwaysBounceVertical = false
        tableView.register(TypeTableViewCell.self, forCellReuseIdentifier: Identifiers.colorTypeCellIdentifier)

        setupTableViewConstraints()
    }

}

// MARK: - Constraints
extension TypeView {

    private func setupTableViewConstraints() {
        addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([tableView.leadingAnchor.constraint(equalTo: leadingAnchor),
                                     tableView.trailingAnchor.constraint(equalTo: trailingAnchor),
                                     tableView.topAnchor.constraint(equalTo: topAnchor),
                                     tableView.bottomAnchor.constraint(equalTo: bottomAnchor)])
    }
}
