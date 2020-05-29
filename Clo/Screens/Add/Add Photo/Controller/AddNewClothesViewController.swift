import UIKit
import FittedSheets

class AddNewClothesViewController: UIViewController {

    // MARK: - Properties
    private let customView = AddNewClothesView(frame: UIScreen.main.bounds)

    // MARK: - Lifecycle
    override func loadView() {
        setupView()
    }

    // MARK: - Functions
    private func view() -> AddNewClothesView {
        return view as! AddNewClothesView
    }

    private func setupView() {
        view  =  customView
        view().delegate = self
    }

    fileprivate func setupPhotoSheet() -> SheetViewController {
        let photoSheetViewController       = PhotoSheetViewController()
        let height                         = view.frame.size.height * 2 / 3
        let sheet                          = SheetViewController(controller: photoSheetViewController, sizes: [.fixed(height)])
        sheet.extendBackgroundBehindHandle = true
        sheet.adjustForBottomSafeArea      = true
        sheet.topCornersRadius             = 15
        sheet.overlayColor                 = .clear
        return sheet
    }

}

// MARK: - AddNewClothesViewDelegate
extension AddNewClothesViewController: AddNewClothesViewDelegate {
    func addPhotoButtonPressed() {
        view().applyBlurEffect(true)
        let sheetViewController = setupPhotoSheet()
        present(sheetViewController, animated: true)

        sheetViewController.didDismiss = { [unowned self] _ in
            self.view().applyBlurEffect(false)

        }
    }
}
