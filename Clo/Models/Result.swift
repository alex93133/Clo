import Foundation

enum Result<Failure: Error> {
    case success
    case failure(Failure)
}
