import UIKit

enum Colors {
    static let border   = UIColor(red: 0.506, green: 0.549, blue: 0.6, alpha: 0.2)
    static let icon     = UIColor(red: 0.6, green: 0.635, blue: 0.678, alpha: 1)
    static let mint     = UIColor(red: 0, green: 0.741, blue: 0.749, alpha: 1)
    static let overlay  = UIColor(red: 0, green: 0, blue: 0, alpha: 0.6)
    static let textGray = UIColor(red: 0.506, green: 0.549, blue: 0.6, alpha: 1)
    static let shadow   = UIColor(red: 0, green: 0, blue: 0, alpha: 0.15)

    static let mainBG = UIColor { traitCollection -> UIColor in
        switch traitCollection.userInterfaceStyle {
        case .unspecified, .light:
            return .white

        case .dark:
            return UIColor(red: 0.2, green: 0.2, blue: 0.2, alpha: 1)
        @unknown default:
            fatalError("New color mode is coming")
        }
    }

    static let additionalBG = UIColor { traitCollection -> UIColor in
        switch traitCollection.userInterfaceStyle {
        case .unspecified, .light:
            return UIColor(red: 0.969, green: 0.969, blue: 0.969, alpha: 1)

        case .dark:
            return UIColor(red: 0.247, green: 0.247, blue: 0.247, alpha: 1)
        @unknown default:
            fatalError("New color mode is coming")
        }
    }

    static let accent = UIColor { traitCollection -> UIColor in
        switch traitCollection.userInterfaceStyle {
        case .unspecified, .light:
            return UIColor(red: 0.2, green: 0.2, blue: 0.2, alpha: 1)

        case .dark:
            return .white
        @unknown default:
            fatalError("New color mode is coming")
        }
    }
}
