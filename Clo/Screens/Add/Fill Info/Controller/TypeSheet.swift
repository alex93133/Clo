import UIKit
import FittedSheets

class TypeSheet {

    var type: TypeViewController!
    var sheet: SheetViewController!

    init() {
        setup()
    }

    private func setup() {
        type                               = TypeViewController()
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
