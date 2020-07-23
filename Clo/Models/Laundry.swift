import Foundation

struct Laundry {
    let name: String
    let color: ColorType
    let temperature: Int
    let washingMode: WashingMode
    let coincidence: Bool
}

extension Laundry {
    init(name: String,
         color: String,
         temperature: Int64,
         washingMode: String,
         coincidence: Bool) {
        self.name        = name
        self.color       = ColorType(rawValue: color)!
        self.temperature = Int(temperature)
        self.washingMode = WashingMode(rawValue: washingMode)!
        self.coincidence = coincidence
    }
}
