import FittedSheets
import UIKit

class AddEditClothesViewController: UIViewController {

    // MARK: - Properties
    private let customView = AddEditClothesView(frame: UIScreen.main.bounds)
    private let clothingColors = ClothingColor.getAllClothingColors()
    private var selectedType: ClothingType?
    private var selectedColor: ColorType?
    private var clothesPhoto: UIImage
    private var editableClothes: Clothes?

    init(image: UIImage? = nil) {
        clothesPhoto = image ?? UIImage()
        super.init(nibName: nil, bundle: nil)
    }

    convenience init(clothes: Clothes) {
        self.init()
        self.editableClothes = clothes
        clothesPhoto         = clothes.photo
        selectedType         = clothes.type
        selectedColor        = clothes.color
        setButtonTitle(NSLocalizedString(clothes.type.rawValue, comment: ""))

        if let info = clothes.info {
            view().inputFieldsView.descriptionTextField.text = info
        }
    }

    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }

    override func viewWillAppear(_: Bool) {
        super.viewWillAppear(true)
        setupNavigationBar()
        checkFields()
    }

    // MARK: - Functions
    private func view() -> AddEditClothesView {
        return view as! AddEditClothesView
    }

    private func setupView() {
        view                                                     = customView
        view().colorTypeCollectionView.collectionView.delegate   = self
        view().colorTypeCollectionView.collectionView.dataSource = self
        view().inputFieldsView.descriptionTextField.delegate     = self
        view().clothesImageView.image                            = clothesPhoto
        setupButtonActions()
    }

    private func setupNavigationBar() {
        let title  = editableClothes == nil ? NSLocalizedString("Add new item", comment: "") : NSLocalizedString("Edit your clothes", comment: "")
        navigationItem.title             = title
        let backUIBarButtonItem          = UIBarButtonItem(image: Images.crossIcon,
                                                           style: .plain,
                                                           target: self,
                                                           action: #selector(backButtonPressed))
        backUIBarButtonItem.tintColor    = Colors.mint
        navigationItem.leftBarButtonItem = backUIBarButtonItem
    }

    private func presentTypeSheet() {
        var clothesTypes = ClothingType.allCases.map { $0.rawValue }
        clothesTypes.removeFirst()
        let typeSheet = ItemSheet(items: clothesTypes)
        typeSheet.itemViewController.delegate = self
        if let selectedType = selectedType {
            typeSheet.itemViewController.selectedItem = selectedType.rawValue
        }
        present(typeSheet.sheet, animated: false)
        typeSheet.sheet.willDismiss = { [weak self] _ in
            guard let self = self else { return }
            self.view().inputFieldsView.selectTypeButton.dropDownIcon.rotate()
        }
    }

    private func presentGallerySheet() {
        let gallerySheet                  = GallerySheet(height: view.frame.size.height * 2 / 3)
        gallerySheet.gallery.itemHasImage = true
        gallerySheet.gallery.delegate     = self
        present(gallerySheet.sheet, animated: false)
    }

    private func presentSelectSymbolsViewController() {
        let selectSymbolsViewController = SelectSymbolsViewController()
        passData(to: selectSymbolsViewController)
        navigationController?.pushViewController(selectSymbolsViewController, animated: true)
    }

    private func setButtonTitle(_ buttonTitle: String) {
        let attributedString = view().inputFieldsView.selectTypeButton.createAttributes(text: buttonTitle,
                                                                                        textColor: Colors.accent)
        view().inputFieldsView.selectTypeButton.setAttributedTitle(attributedString, for: .normal)
    }

    private func checkFields() {
        guard selectedType != nil else { return }
        guard selectedColor != nil else { return }
        view().nextButton.enableButton(isOn: true)
    }

    private func passData(to viewController: SelectSymbolsViewController) {
        guard let selectedType = selectedType else { return }
        guard let selectedColor = selectedColor else { return }
        guard let photo = view().clothesImageView.image else { return }

        viewController.clothesInfo = (type: selectedType,
                                      color: selectedColor,
                                      info: view().inputFieldsView.descriptionTextField.text,
                                      photo: photo)

        if let editableClothes = editableClothes {
            viewController.editableClothes = editableClothes
        }
    }

    // MARK: - Actions
    private func setupButtonActions() {
        view().changePhotoButtonHandler = { [weak self] in
            guard let self = self else { return }
            self.presentGallerySheet()
        }

        view().inputFieldsView.selectTypeButtonHandler = { [weak self] in
            guard let self = self else { return }
            self.view.endEditing(true)
            self.presentTypeSheet()
        }
        view().nextButtonHandler = { [weak self] in
            guard let self = self else { return }
            self.presentSelectSymbolsViewController()
        }
        view().nextButton.enableButton(isOn: false)
    }

    @objc
    private func backButtonPressed() {
        if editableClothes != nil {
            navigationController?.popViewController(animated: true)
        } else {
            dismiss(animated: true)
        }
    }
}

// MARK: - Delegates
extension AddEditClothesViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_: UICollectionView, numberOfItemsInSection _: Int) -> Int {
        clothingColors.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Identifiers.clothesColorCellIdentifier,
                                                         for: indexPath) as? ColorTypeCollectionViewCell {

            cell.colorTypeImageView.image = clothingColors[indexPath.item].image

            if clothingColors[indexPath.item].type == selectedColor {
                cell.colorTypeImageView.alpha = 0.3
            } else {
                cell.colorTypeImageView.alpha = 1
            }
            return cell
        }
        return UICollectionViewCell()
    }

    func collectionView(_: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        FeedbackManager.select()
        selectedColor = clothingColors[indexPath.item].type
        view().colorTypeCollectionView.collectionView.reloadData()
        checkFields()
    }
}

extension AddEditClothesViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_: UITextField) -> Bool {
        view().inputFieldsView.descriptionTextField.resignFirstResponder()
        return true
    }

    func textFieldDidBeginEditing(_: UITextField) {
        view().changePhotoButton.isEnabled = false
    }

    func textFieldDidEndEditing(_: UITextField) {
        view().changePhotoButton.isEnabled = true
    }
}

extension AddEditClothesViewController: ItemViewControllerDelegate {
    func applySelectedItem(with item: String) {
        guard let type = ClothingType(rawValue: item) else { return }
        selectedType = type
        let buttonTitle = NSLocalizedString(type.rawValue, comment: "")
        setButtonTitle(buttonTitle)
        checkFields()
    }
}

extension AddEditClothesViewController: GalleryViewControllerDelegate {
    func updateImage(with image: UIImage) {
        view().clothesImageView.image = image
    }
}
