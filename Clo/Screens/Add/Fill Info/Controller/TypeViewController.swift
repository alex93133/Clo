import UIKit

class TypeViewController: UITableViewController {

    // MARK: - Properties
    private let customView    = TypeView(frame: UIScreen.main.bounds)
    private let clothingTypes = ClothingType.allCases
    var selectedType: ClothingType!
    var selectedTypeHandle: ((ClothingType) -> Void)?

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }

    // MARK: - Functions
    private func view() -> TypeView {
        return view as! TypeView
    }

    private func setupView() {
        view  =  customView
        view().tableView.delegate = self
        view().tableView.dataSource = self
        
        if let selectedType = selectedType {
            guard let index = clothingTypes.firstIndex(of: selectedType) else { return }
            let indexPath = IndexPath(row: index, section: 0)
            view().tableView.selectRow(at: indexPath, animated: false, scrollPosition: .none)
        }
    }
}

// MARK: - Delegates
extension TypeViewController {

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        clothingTypes.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: Identifiers.colorTypeCellIdentifier) as? TypeTableViewCell {
            cell.textLabel?.text = clothingTypes[indexPath.row].rawValue
            return cell
        } else {
            return UITableViewCell()
        }
    }

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return Constants.colorTypeCellHeight
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedType = clothingTypes[indexPath.row]
        DispatchQueue.main.asyncAfter(deadline: .now() + Constants.animationTimeInterval) { [unowned self] in
            self.selectedTypeHandle?(self.selectedType)
        }
    }
}
