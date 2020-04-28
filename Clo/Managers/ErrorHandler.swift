import Foundation


enum ErrorHandler: Error {
    case emptyFields
    case passwordAreNotSimilar
    case invalidEmail
    case shortPassword
}

extension ErrorHandler: LocalizedError {
    public var errorDescription: String? {
        switch self {
        case .emptyFields:
            return NSLocalizedString("Fields are empty", comment: "")
        case .passwordAreNotSimilar:
            return NSLocalizedString("Passwords should be similar", comment: "")
        case .invalidEmail:
            return NSLocalizedString("Wrong email type", comment: "")
        case .shortPassword:
            return NSLocalizedString("Too short password", comment: "")
        }
    }
}
