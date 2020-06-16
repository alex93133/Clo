import UIKit
import FittedSheets

class TypeSheet {

    var type = TypeViewController()
    var sheet: SheetViewController!

    init(hideCategoryNamedAll: Bool = false) {
        if hideCategoryNamedAll {
            type.clothingTypes.removeFirst()
        }
        setup()
    }

    private func setup() {
        let safeZoneHeight: CGFloat        = 70
        let height: CGFloat                = Constants.colorTypeCellHeight * CGFloat(type.clothingTypes.count) + safeZoneHeight
        sheet                              = SheetViewController(controller: type, sizes: [.fixed(height)])
        sheet.extendBackgroundBehindHandle = true
        sheet.adjustForBottomSafeArea      = true
        sheet.blurBottomSafeArea           = true
        sheet.topCornersRadius             = 15
        sheet.overlayColor                 = Colors.overlayColor
    }
}
