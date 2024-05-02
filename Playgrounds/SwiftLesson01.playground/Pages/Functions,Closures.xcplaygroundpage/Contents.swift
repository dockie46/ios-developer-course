//: [Previous](@previous)

//import Foundation
//
//var greeting = "Hello, playground"
//
//func helloWorld () {}
//func helloWOrld () -> Void {}
//
////() -> Void
//
//typealias EmptyClosures =  () -> Void
//
//let myEmptyClosures: EmptyClosures = {
//    print("test")
//}
//
//myEmptyClosures()
//
//func myFunction(inputFunction: @escaping EmptyClosures) -> EmptyClosures
//{
//    inputFunction
//}

func countingWith(with inputFunction: (Int, Int) -> Void)
{
    let a = 5
    inputFunction(a, a)
    print("Counting \(a)")
}

func counting(_ inputFunction: (Int, Int) -> Void)
{
    let a = 5
    inputFunction(a, a)
    print("Counting \(a)")
}

counting() { value, value2 in
    print("Print \(value) inside")
}

countingWith() { value, value2 in
    print("Print \(value) inside")
}

//: [Next](@next)

func combine(a: Int, b: Int, with block: (Int, Int) -> Int) -> Int {
       // Here we call the closure with the specified parameters
       block(a, b)
   }

   // This is a closure that takes two numbers and subtracts the second one from the first one
   let subtract: (Int, Int) -> Int = { a, b in
       a - b
   }

   // Now we can call the `combine` function with two numbers and provided with the closure that subtracts them
   let subtraction = combine(a: 1, b: 2, with: subtract)
   print(subtraction)

   // We can also define the closure right in the function call
   // In this case we add the numbers
   let addition = combine(a: 1, b: 2, with: { a, b in
       a + b
   })
   print(addition)

   // typealias
   typealias IntOperation = (Int, Int) -> Int
   typealias IntCallback = (Int) -> Void

   func combine(a: Int, b: Int, with block: IntOperation, callback: IntCallback) {
       
       // Here we call the closure with the specified parameters
       let heavyOperation = block(a,b)
       callback(heavyOperation)

       //callback(block(a, b)
   }

   combine(a: 10, b: 11, with: { $0 + $1 }, callback: { print("test \($0)") })
