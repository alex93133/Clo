import MessageUI
import StoreKit
import UIKit

class MenuViewController: UIViewController {

    // MARK: - Properties
    private let customView = MenuView(frame: UIScreen.main.bounds)
    private let cellTitles = [ "Buy coffee for developer",
                               "Rate us",
                               "Feedback" ]

    private let cellIcons = [ Images.Menu.coffee,
                              Images.Menu.star,
                              Images.Menu.feedback]

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()

        let manager = InAppPurchaseManager.shared
        manager.setupPurchases { success in
            guard success else { return }
            manager.getProducts()
        }
    }

    // MARK: - Functions
    private func view() -> MenuView {
        return view as! MenuView
    }

    private func setupView() {
        view                        = customView
        view().tableView.delegate   = self
        view().tableView.dataSource = self
    }

    private func sendEmail() {
        guard MFMailComposeViewController.canSendMail() else { return }
        let mail = MFMailComposeViewController()
        mail.mailComposeDelegate = self
        mail.setToRecipients(["ya.lex93133@ya.ru"])
        present(mail, animated: true)
    }

    private func rateUs() {
        SKStoreReviewController.requestReview()
    }
}

// MARK: - Delegates
extension MenuViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        3
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: Identifiers.menuItemCellIdentifier) as? MenuItemTableViewCell {
            cell.textLabel?.text = cellTitles[indexPath.row]
            cell.imageView?.image = cellIcons[indexPath.row]

            if indexPath.row == 0 {
                cell.textLabel?.textColor = Colors.mint
            }

            return cell
        }
        return UITableViewCell()
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.row {
        case 1:
            rateUs()

        case 2:
            sendEmail()

        default:
            return
        }
    }
}

extension MenuViewController: MFMailComposeViewControllerDelegate {
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        controller.dismiss(animated: true)
    }
}
