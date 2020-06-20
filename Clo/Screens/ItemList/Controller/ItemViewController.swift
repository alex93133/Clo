import UIKit

protocol ItemViewControllerDelegate: class {
    func applySelectedItem(with item: String)
}

class ItemViewController: UITableViewController {
  
    // MARK: - Properties
    private let customView = ItemView(frame: UIScreen.main.bounds)
    var items: [String]
    var selectedItem: String?
    weak var delegate: ItemViewControllerDelegate!

    init(items: [String]) {
        self.items = items
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }

    // MARK: - Functions
    private func view() -> ItemView {
        return view as! ItemView
    }

    private func setupView() {
        view                        = customView
        view().tableView.delegate   = self
        view().tableView.dataSource = self

        if let selectedItem = selectedItem {
            guard let index = items.firstIndex(of: selectedItem) else { return }
            let indexPath = IndexPath(row: index, section: 0)
            view().tableView.selectRow(at: indexPath, animated: false, scrollPosition: .none)
        }
    }
}

// MARK: - Delegates
extension ItemViewController {
   
    override func tableView(_: UITableView, numberOfRowsInSection _: Int) -> Int {
        items.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: Identifiers.colorTypeCellIdentifier) as? ItemTableViewCell {
            cell.textLabel?.text = items[indexPath.row]
            return cell
        } else {
            return UITableViewCell()
        }
    }

    override func tableView(_: UITableView, heightForRowAt _: IndexPath) -> CGFloat {
        return Constants.colorTypeCellHeight
    }

    override func tableView(_: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedItem = items[indexPath.row]
        DispatchQueue.main.asyncAfter(deadline: .now() + Constants.animationTimeInterval) { [weak self] in
            guard let self = self else { return }
            guard let selectedItem = self.selectedItem else { return }
            self.delegate?.applySelectedItem(with: selectedItem)
            self.sheetViewController?.closeSheet()
        }
    }
}
