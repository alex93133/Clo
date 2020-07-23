import UIKit

class MenuView: UIView {

    // MARK: - Properties
    var logoImageView: UIImageView!
    var versionLabel: UILabel!
    var tableView: UITableView!

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLogoImageView()
        setupVersionLabel()
        setupTableView()
        backgroundColor = Colors.mainBG
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    // MARK: - LogoImageView
    private func setupLogoImageView() {
        logoImageView             = UIImageView()
        logoImageView.contentMode = .scaleAspectFit
        logoImageView.image       = Images.logoImage
        setupLogoImageViewConstraints()
    }

    // MARK: - VersionLabel
    private func setupVersionLabel() {
        versionLabel = UILabel()
        versionLabel.textAlignment = .center
        versionLabel.textColor = Colors.textGray
        versionLabel.font = .systemFont(ofSize: Constants.Fonts.smallTextSize, weight: .regular)

        if let version = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String {
            versionLabel.text =  NSLocalizedString("Version", comment: "") + " " + version
        }
        setupVersionLabelConstraints()
    }

    // MARK: - TableView
    private func setupTableView() {
        tableView                 = UITableView()
        tableView.tableFooterView = UIView()
        tableView.backgroundColor = Colors.mainBG
        tableView.separatorColor  = Colors.border
        tableView.rowHeight       = UITableView.automaticDimension
        tableView.isScrollEnabled = false
        tableView.register(MenuItemTableViewCell.self, forCellReuseIdentifier: Identifiers.menuItemCellIdentifier)
        setupTableViewConstraints()
    }

    // MARK: - Constraints
    private func setupLogoImageViewConstraints() {
        addSubview(logoImageView)
        logoImageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            logoImageView.heightAnchor.constraint(equalToConstant: 57),
            logoImageView.widthAnchor.constraint(equalToConstant: 151),
            logoImageView.centerXAnchor.constraint(equalTo: centerXAnchor),
            logoImageView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 32)
        ])
    }

    private func setupVersionLabelConstraints() {
        addSubview(versionLabel)
        versionLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            versionLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 24),
            versionLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -24),
            versionLabel.heightAnchor.constraint(equalToConstant: 18),
            versionLabel.topAnchor.constraint(equalTo: logoImageView.bottomAnchor, constant: 16)
        ])
    }

    private func setupTableViewConstraints() {
        addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            tableView.leadingAnchor.constraint(equalTo: leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: trailingAnchor),
            tableView.topAnchor.constraint(equalTo: versionLabel.bottomAnchor, constant: 32),
            tableView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
}
