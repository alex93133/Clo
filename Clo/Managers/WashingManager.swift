import UIKit

struct WashingManager {

    func getTemperature(clothes: Clothes) -> Int? {
        let washingSymbol = clothes.symbols.filter { $0.category == .washing }
        guard let symbol = washingSymbol.first else { return nil }

        switch symbol.id {
        case 6, 11, 16, 21, 26, 31:
            return 30

        case 7, 12, 17, 22, 27, 32:
            return 40

        case 8, 13, 18, 23, 28, 33:
            return 60

        case 9, 14, 19, 24, 29, 34:
            return 70

        case 10, 15, 20, 25, 30, 35:
            return 95

        default:
            return nil
        }
    }

    func getWashingMode(clothes: Clothes) -> WashingMode? {
        let washingSymbol = clothes.symbols.filter { $0.category == .washing }
        guard let symbol = washingSymbol.first else { return nil }

        switch symbol.id {
        case 0..<11, 21..<26:
            return .regular

        case 11..<16, 26..<31:
            return.gentle

        case 16..<21, 31..<36:
            return .veryGentle

        default:
            return nil
        }
    }
}
