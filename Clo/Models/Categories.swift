import Foundation

enum Categories: String, Codable, CaseIterable {
    case washing              = "Washing"
    case bleaching            = "Bleaching"
    case tumbleDrying         = "Tumble drying"
    case naturalDrying        = "Natural drying"
    case ironing              = "Ironing"
    case professionalCleaning = "Professional cleaning"
}
