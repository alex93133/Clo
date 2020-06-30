import FittedSheets
import UIKit

class WashingFilterSheet {

    // MARK: - Properties
    var sheet: SheetViewController!
    var washingFilter: WashingFilterViewController!

    init() {
        washingFilter = WashingFilterViewController()
        setup()
    }

    // MARK: - Functions
    private func setup() {
        sheet                              = SheetViewController(controller: washingFilter, sizes: [.fixed(560)])
        sheet.extendBackgroundBehindHandle = true
        sheet.blurBottomSafeArea           = false
        sheet.topCornersRadius             = 15
        sheet.overlay                      = Colors.overlay
        sheet.handleSize                   = CGSize(width: 31, height: 3)
    }
}
