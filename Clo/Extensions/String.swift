import Foundation

extension String {
//    var isValidName: Bool {
//        let nameFormat = "[A-Za-zА-Яа-я_ -]{2,64}"
//        let namePredicate = NSPredicate(format:"SELF MATCHES %@", nameFormat)
//        return namePredicate.evaluate(with: self)
//    }

    var isValidEmail: Bool {
        let emailFormat = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPredicate = NSPredicate(format: "SELF MATCHES %@", emailFormat)
        return emailPredicate.evaluate(with: self)
    }
}
