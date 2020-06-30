import MessageUI
import StoreKit
import UIKit

class MenuViewController: UIViewController {

    // MARK: - Properties
    private let customView = MenuView(frame: UIScreen.main.bounds)
    private let cellTitles = [ NSLocalizedString("Buy coffee for developers", comment: ""),
                               NSLocalizedString("Rate us", comment: ""),
                               NSLocalizedString("Feedback", comment: "") ]

    private let cellIcons = [ Images.Menu.coffee,
                              Images.Menu.star,
                              Images.Menu.feedback]
    private var manager: InAppPurchaseManager!
    private var productsList: UIAlertController!

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
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

    private func buyCoffee() {
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(presentProducts),
                                               name: NSNotification.Name(rawValue: Identifiers.Notifications.productsGot),
                                               object: nil)
        manager = InAppPurchaseManager.shared
        manager.setupPurchases {[weak self]  success in
            guard let self = self else { return }
            guard success else { return }
            self.manager.getProducts()
        }
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

    private func productTitle(product: SKProduct) -> String {
        let numberFormatter         = NumberFormatter()
        numberFormatter.numberStyle = .currency
        numberFormatter.locale      = product.priceLocale
        return product.localizedTitle + " – " + numberFormatter.string(from: product.price)!
    }

    // MARK: - Actions
    @objc
    private func presentProducts() {

        let products = InAppPurchaseManager.shared.products
        guard products.count == 3 else { return }

        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }

            self.productsList = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
            self.productsList.view.tintColor = Colors.mint

            let americano    = products.first { $0.productIdentifier == Identifiers.PurchasesID.americano.rawValue }
            let cappuccino   = products.first { $0.productIdentifier == Identifiers.PurchasesID.cappuccino.rawValue }
            let latte        = products.first { $0.productIdentifier == Identifiers.PurchasesID.latte.rawValue }
            let cancelAction = UIAlertAction(title: NSLocalizedString("Cancel", comment: ""), style: .cancel)

            self.productsList.addAction(cancelAction)
            self.createAction(product: americano, image: (Images.Menu.americano!.withRenderingMode(.alwaysOriginal)))
            self.createAction(product: cappuccino, image: (Images.Menu.cappuccino!.withRenderingMode(.alwaysOriginal)))
            self.createAction(product: latte, image: (Images.Menu.latte!.withRenderingMode(.alwaysOriginal)))

            self.present(self.productsList, animated: true)
        }
    }

    private func createAction(product: SKProduct?, image: UIImage) {
        guard let product = product else { return }
        let action = UIAlertAction(title: productTitle(product: product), style: .default) { [weak self] _ in
            guard let self = self else { return }
            self.manager.purchase(product: product)
        }
        action.setValue(CATextLayerAlignmentMode.left, forKey: "titleTextAlignment")
        action.setValue(image.withRenderingMode(.alwaysOriginal), forKey: "image")
    
        productsList.addAction(action)
    }
}

// MARK: - Delegates
extension MenuViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        3
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: Identifiers.menuItemCellIdentifier) as? MenuItemTableViewCell {
            cell.textLabel?.text  = cellTitles[indexPath.row]
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
        case 0:
            buyCoffee()

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
