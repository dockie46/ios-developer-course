import Foundation

struct Person : Equatable {
    let firstName: String
    let lastName: String
}

struct Human  {
    var firstName: String
    let lastName: String
    
    mutating func changeName (newName: String) {
        firstName = newName
    }
}

let person = Person(firstName: "CJ", lastName: "Parker")
//person.firstName = "Mitch"

let human = Human(firstName: "CJ", lastName: "Parker")
//homan.firstName = "Mitch"

var humanFromBayWatch = Human(firstName: "CJ", lastName: "Parker")
humanFromBayWatch.firstName = "Mitch"


let personSecond = Person(firstName: "CJ", lastName: "Parker")
print(person == personSecond)

class Lesson : Equatable {
    static func == (lhs: Lesson, rhs: Lesson) -> Bool {
        lhs.name == rhs.name
    }
    
    init(name: String) {
        self.name = name
    }
    
    let name: String
}

let l1 = Lesson(name: "test")
let l2 = Lesson(name: "test")

print(l1 == l2)
print(l1 === l2)
