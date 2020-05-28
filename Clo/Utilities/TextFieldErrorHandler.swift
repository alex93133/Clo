import Foundation

enum TextFieldErrorHandler: Error {
    case emptyFields
    case passwordAreNotSimilar
    case invalidEmail
}

extension TextFieldErrorHandler: LocalizedError {
    public var errorDescription: String? {
        switch self {
        case .emptyFields:
            return NSLocalizedString("Fields are empty", comment: "")
        case .passwordAreNotSimilar:
            return NSLocalizedString("Passwords should be similar", comment: "")
        case .invalidEmail:
            return NSLocalizedString("Wrong email type", comment: "")
        }
    }
}

enum Response {
    case success
    case failure (errorString: String)
}
