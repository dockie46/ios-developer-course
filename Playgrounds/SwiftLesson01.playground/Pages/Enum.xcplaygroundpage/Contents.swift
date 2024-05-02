//: [Previous](@previous)

import Foundation

enum LanguageEnum: String, Error {
    case objc
    case swift = "swift"
}

let language = LanguageEnum.swift

print(language)
print(language.rawValue)
//: [Next](@next)

enum Country : Equatable {
    case czech(currency: String)
    case slovak(currency: String)
}

let actualSlovakEnumValue = Country.slovak(currency: "Kc")
let newCzech = Country.czech(currency: "Eur")

if case let .czech(currency) = actualSlovakEnumValue {
    print(currency)
}

switch actualSlovakEnumValue {
case let .czech(currency):
    print(currency)
case let .czech(currency):
    print(currency)
default:
    print("nothing here")
}

enum AuthPermission {
    case notDetermined
    case authorized
    case denied
}

let authResponse = AuthPermission.denied

switch authResponse {
case .authorized:
    print("authorized")
case .notDetermined, .denied:
    fallthrough
@unknown default:
    print("test")
}


//enum Country : Equatable {
//    case czech(currency: String)
//
//    static func == (lhs: Country, rhs: Country) -> Bool {
//
//        switch(lhs, rhs) {
//        case let .czech(currencylhs), .czech(currencylhs):
//            currencyrhs == currencylhs
//        }
//    }
//}
//

//
//print(czech == newCzech)
