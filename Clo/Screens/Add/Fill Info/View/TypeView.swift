import UIKit

class TypeView: UIView {
    
    var tableView: UITableView!

    // MARK: - Properties
      

       override init(frame: CGRect) {
           super.init(frame: frame)
        setupTableView()
           backgroundColor = Colors.whiteBGColor
       }

       required init?(coder: NSCoder) {
           super.init(coder: coder)
       }
    
    private func setupTableView() {
        tableView = UITableView()
        tableView.tableFooterView = UIView()
        tableView.backgroundColor = Colors.whiteBGColor
        tableView.separatorColor = Colors.separator
        tableView.alwaysBounceVertical = false
        tableView.register(TypeTableViewCell.self, forCellReuseIdentifier: Identifiers.colorTypeCellIdentifier)

        setupTableViewConstraints()
    }
    
}

extension TypeView {
    
    private func setupTableViewConstraints() {
        addSubview(tableView)
        
        tableView.translatesAutoresizingMaskIntoConstraints                   = false
        tableView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive   = true
        tableView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        tableView.topAnchor.constraint(equalTo: topAnchor).isActive           = true
        tableView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive     = true
    }
}
