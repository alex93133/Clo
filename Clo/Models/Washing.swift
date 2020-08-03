import Foundation

struct Washing {
    let name: String
    let color: ColorType
    let temperature: Int
    let washingMode: WashingMode
    let coincidence: Bool
    let creationDate: Date
}

extension Washing {
    init(name: String,
         color: String,
         temperature: Int64,
         washingMode: String,
         coincidence: Bool,
         creationDate: Date) {
        self.name         = name
        self.color        = ColorType(rawValue: color)!
        self.temperature  = Int(temperature)
        self.washingMode  = WashingMode(rawValue: washingMode)!
        self.coincidence  = coincidence
        self.creationDate = creationDate
    }
}
