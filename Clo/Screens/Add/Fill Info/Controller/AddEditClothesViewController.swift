import UIKit
import FittedSheets

class AddEditClothesViewController: UIViewController {
    
    // MARK: - Properties
    private let customView = AddEditClothesView(frame: UIScreen.main.bounds)
    private let clothingColors = ClothingColor.getAllClothingColors()
    private var selectedType: ClothingType?
    private var selectedColor: ColorType?
    private var clothesPhoto: UIImage
    private var editableClothes: Clothes?
    
    init(image: UIImage? = nil) {
        self.clothesPhoto = image ?? UIImage()
        super.init(nibName: nil, bundle: nil)
    }
    
    convenience init(clothes: Clothes) {
        self.init()
        self.editableClothes      = clothes
        guard let editableClothes = self.editableClothes else { return }
        self.clothesPhoto         = editableClothes.photo
        self.selectedType         = editableClothes.type
        self.selectedColor        = editableClothes.color
        self.setButtonTitle(clothes.type.rawValue)
        
        if let info = editableClothes.info {
            self.view().inputFieldsView.descriptionTextField.text = info
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupNavigationBar()
    }
    
    override func viewWillAppear(_ animated: Bool) {
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
        let title                        = editableClothes == nil ? "Add new item" : "Edit your clothes"
        navigationItem.title             = title
        let backUIBarButtonItem          = UIBarButtonItem(image: Images.backIcon, style: .plain, target: self, action: #selector(backButtonPressed))
        backUIBarButtonItem.tintColor    = Colors.mintColor
        navigationItem.leftBarButtonItem = backUIBarButtonItem
    }
    
    static func createTypeSheet(typeViewController: TypeViewController) -> SheetViewController {
        let safeZoneHeight: CGFloat            = 70
        let height: CGFloat                    = Constants.colorTypeCellHeight * CGFloat(typeViewController.clothingTypes.count) + safeZoneHeight
        let clothingTypeViewController         = typeViewController
        let typeSheet                          = SheetViewController(controller: clothingTypeViewController, sizes: [.fixed(height)])
        typeSheet.extendBackgroundBehindHandle = true
        typeSheet.adjustForBottomSafeArea      = true
        typeSheet.blurBottomSafeArea           = true
        typeSheet.topCornersRadius             = 15
        typeSheet.overlayColor                 = Colors.overlayColor
        return typeSheet
    }
    
    private func presentTypeSheet() {
        let typeViewController  = TypeViewController()
        typeViewController.clothingTypes.removeFirst()
        let sheetViewController = AddEditClothesViewController.createTypeSheet(typeViewController: typeViewController)
        
        if let selectedType     = editableClothes?.type {
            typeViewController.selectedType = selectedType
        }
        present(sheetViewController, animated: false)
        
        typeViewController.selectedTypeHandle = { [weak self] type in
            guard let self = self else { return }
            self.selectedType = type
            let buttonTitle   = type.rawValue
            self.setButtonTitle(buttonTitle)
            sheetViewController.closeSheet()
            self.checkFields()
        }
    }
    
    private func setButtonTitle(_ buttonTitle: String) {
        let attributedString = self.view().inputFieldsView.createAttributes(text: buttonTitle,
                                                                            textColor: Colors.blackTextColor)
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
}

// MARK: - Actions
extension AddEditClothesViewController {
    
    private func setupButtonActions() {
        
        view().changePhotoButtonHandler = { [weak self] in
            guard let self = self else { return }
            let sheet                                      = PhotoSheet()
            let photoSheetViewController                   = sheet.setupGallerySheet(height:  self.view.frame.size.height * 2 / 3)
            sheet.galleryViewController.itemHasImage       = true
            sheet.galleryViewController.updateImageHandler = { image in
                self.view().clothesImageView.image = image
                DispatchQueue.main.asyncAfter(deadline: .now() + 2 * Constants.animationTimeInterval) {
                    sheet.gallerySheet.closeSheet()
                }
            }
            self.present(photoSheetViewController, animated: false)
        }
        
        view().inputFieldsView.selectTypeButtonHandler = { [weak self]  in
            guard let self = self else { return }
            self.presentTypeSheet()
        }
        view().nextButtonHandler = { [weak self]  in
            guard let self = self else { return }
            self.presentSelectSymbolsViewController()
        }
        view().nextButton.enableButton(isOn: false)
    }
    
    @objc private func backButtonPressed() {
        if editableClothes != nil {
            navigationController?.popViewController(animated: true)
        } else {
            let tabBraController = TabBarController()
            tabBraController.modalPresentationStyle = .fullScreen
            present(tabBraController, animated: true)
        }
    }
    
    private func presentSelectSymbolsViewController() {
        let selectSymbolsViewController = SelectSymbolsViewController()
        passData(to: selectSymbolsViewController)
        navigationController?.pushViewController(selectSymbolsViewController, animated: true)
    }
}

// MARK: - Delegates
extension AddEditClothesViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        clothingColors.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if  let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Identifiers.clothesColorCellIdentifier, for: indexPath) as? ColorTypeCollectionViewCell {
            cell.colorTypeImageView.image = clothingColors[indexPath.item].image
            
            if selectedColor != nil && clothingColors[indexPath.item].type != selectedColor {
                cell.colorTypeImageView.alpha = 0.5
            } else {
                cell.colorTypeImageView.alpha = 1
            }
            return cell
        }
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        selectedColor = clothingColors[indexPath.item].type
        view().colorTypeCollectionView.collectionView.reloadData()
        checkFields()
    }
}

extension AddEditClothesViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        view().inputFieldsView.descriptionTextField.resignFirstResponder()
        return true
    }
}
