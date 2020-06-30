import FittedSheets
import UIKit

class WashingFilterSheet {

    // MARK: - Properties
    var sheet: SheetViewController!
    var washingFilter: WashingFilterViewController!

    init() {
        setup()
    }

    // MARK: - Functions
    private func setup() {
        washingFilter                      = WashingFilterViewController()
        sheet                              = SheetViewController(controller: washingFilter, sizes: [.fixed(560)])
        sheet.extendBackgroundBehindHandle = true
        sheet.blurBottomSafeArea           = false
        sheet.topCornersRadius             = 15
        sheet.overlay                      = Colors.overlay
        sheet.handleSize                   = CGSize(width: 31, height: 3)
    }
}
