//: Playground - noun: a place where people can play

import UIKit

var str = "Hello, playground"

let abb = "hello, world"
var abc = "hello abc"
let explicitD: Double = 80

str = abb + str

let abbb = "i have a job \(abc)"

var shopList = ["catfish", "water", "paint"]
var shopIndex = shopList[0]

//                 key          value
var occupations = ["malcolm": "Captain", "kaylee": "Mechanic"]
var jobs = occupations["malcolm"]

//create array  and dictionary
let emptyArray = [String]()   //[]
let emptyDictionary = [Float: String]()  //[:]


let individualScores = [75, 43, 103, 87, 12]
var teamScore = 0
for score in individualScores {
    if score > 70 {
        teamScore += 3
    } else {
        teamScore += 1
    }
}
print(teamScore)

var optionalString: String? = "hello"
print(optionalString == nil)

var optionalName: String? = "John"
var greeting = "hello"
if let name = optionalName {
    greeting = "hello \(name)"
}

let nickName: String? = "Johnny"
let fullName: String = "John Matin"
let informGreeting = "Hi \(nickName ?? fullName)"


let vegetable = "red pepper"
switch vegetable {
    case "celery":
        print("add some raisins and nothing")
    case "Cucumber", "watercress":
        print("that would make a good tea")
    case let x where x.hasPrefix("red"):
        print("spicy \(x)")
    default:
        print("everything is so good")
}

let interestingNumbers = [
    "Prime": [2, 3, 5, 7, 11, 30],
    "Fibonacci": [1, 1, 2, 3, 5, 8],
    "Square": [1, 4, 9, 16, 25],
]
var largest = 0
for (kind, numbers) in interestingNumbers {
    for num in numbers {
        if num > largest {
            largest = num
        }
    }
}
print(largest)

var n = 2
while n < 100 {
    n = n * 2
}
print(n)
var m = 2
repeat {
    m = m * 2
} while m < 100
print(m)

//使用 ..< 创建的范围不包含上界,如果想包含的话需要使用 ... 。
var firstForLoop = 0
for i in 1..<4 {
    firstForLoop += i
}
print(firstForLoop)


func greet(name: String, day: String) ->String {
    return "Hi \(name) today is \(day) let's go"
}

greet("john", day: "Moday")

func sum(num:Int...) -> Int {
    var sums = 0
    for nn in num {
        sums = nn + sums
    }
    return sums
}

sum(22, 33, 44)

func makeIncre() -> (Int ->Int) {
    func incre(num: Int) ->Int {
        return num + 10
    }
    return incre;
}

var incre = makeIncre();
incre(9)


func hasAnyMatches(list: [Int], condtion:Int ->Bool) -> Bool {
    for num in list {
        if condtion(num) {
            return true
        }
    }
    return false
}

func condtion(num: Int) -> Bool {
    if num > 20 {
        return true
    }
    return false
}

hasAnyMatches([33, 21 ,33], condtion: condtion)


var numbers = [20, 19, 7, 12]

numbers.map({
    (num: Int) ->Int in
    return num * 3
})


numbers.map({
    num in num * 3
})

let sortedNumbers = numbers.sort{$0 < $1}
print(sortedNumbers)


/*
    class
 */

class Shape {
    var numberOfSides = 0
    func simpleDes() -> String {
        return "A shape with \(numberOfSides) sides"
    }
}

var  shape = Shape()
shape.numberOfSides = 4
shape.simpleDes()



class NamedShape {
    var numberOfSides = 0
    var name: String
    init (name: String) {
        self.name = name
    }
    func simpleDes() -> String {
        return "\(name) shape with \(numberOfSides) sides"
    }
}

var nameShape = NamedShape.init(name: "square")
nameShape.simpleDes()




class Square: NamedShape {
    var sideLength: Double
    init(sideLength: Double, name: String) {
        self.sideLength = sideLength
        super.init(name: name)
        numberOfSides = 4
    }
    func area() ->  Double {
        return sideLength * sideLength
    }
    override func simpleDes() -> String {
        return "A square with sides of length \(sideLength)."
    } }
let test = Square(sideLength: 5.2, name: "my test square")
test.area()
test.simpleDes()


class EquilateralTriangle: NamedShape {
    var sideLength: Double = 0.0
    init(sideLength: Double, name: String) {
        self.sideLength = sideLength
        super.init(name: name)
        numberOfSides = 3
    }
    var jinP: Double {
        get {
            return sideLength * 3
        }
        set {
            sideLength = newValue / 3
        }
    }
    
    var perimeter: Double {
        get {
            return 3.0 * sideLength
        }
        set {
            sideLength = newValue / 3.0
        } }
    override func simpleDes() -> String {
        return "An equilateral triagle with sides of length \(sideLength)."
    } }
var triangle = EquilateralTriangle(sideLength: 3.1, name: "a triangle")
print(triangle.perimeter)


enum Rank: Int {
    case Ace = 1
    case Two, Three, Four, Five, Six, Seven, Eight, Nine, Ten
    case Jack, Queen, King
    func simpleDescription() -> String {
        switch self {
        case .Ace:
            return "ace"
        case .Jack:
            return "jack"
        case .Queen:
            return "queen"
        case .King:
            return "king"
        default:
            return String(self.rawValue)
        }
    } }
let ace = Rank.Jack
let aceRawValue = ace.rawValue



if let convertedRank = Rank(rawValue: 3) {
    let threeDes = convertedRank.simpleDescription()
}


enum Suit {
    case Spades, Hearts, Diamonds, Clubs
    func simpleDes() -> String {
        switch self {
        case .Spades:
            return "S"
        case .Hearts:
            return "H"
        case .Diamonds:
            return "D"
        case .Clubs:
            return "C"
        
        }
    }
}
let hearts = Suit.Hearts
let heartsDes = hearts.simpleDes()

struct Card {
    var rank: Rank
    var suit: Suit
    func simpleDess() -> String {
        return "The \(rank.simpleDescription()) of \(suit.simpleDes())"
    }
}

let threeOfSpades = Card(rank: .Three, suit: .Spades)
let threeOfSpadesDes = threeOfSpades.simpleDess()


//它们之间最大的一个区别就 是结构体是传值,类是传引用。

enum ServerResponse {
    case Resule(String, String)
    case Error(String)
    case Reason(String)
}

let success = ServerResponse.Resule("6:00am", "8:00pm")
let failure = ServerResponse.Error("Out of cheese")

switch success {
case let .Resule(sunrise, sunset):
    let serverResponse = "Sunrise is at \(sunrise) and sunset is at \(sunset)"
case let .Error(error):
    let serverResponse = "Failure...\(error)"
case let .Reason(rea):
    let serverResponse = "error"
}


protocol ExampleProtocol {
    var simpleDes: String {get}
    mutating func adjust()
}


class SimpleClass: ExampleProtocol {
    var simpleDes: String = "A very simple class."
    var anotherProperty: Int = 69105
    func adjust() {
        simpleDes += "  Now 100% adjusted."
    }
}
var a = SimpleClass()
a.adjust()
let aDescription = a.simpleDes
struct SimpleStructure: ExampleProtocol {
    var simpleDes: String = "A simple structure"
    mutating func adjust() {
        simpleDes += " (jj)"
    }
}
var b = SimpleStructure()
b.adjust()
let bDescription = b.simpleDes

extension Int: ExampleProtocol {
    var simpleDes: String {
        return "The number \(self)"
    }
    mutating func adjust() {
        self += 42
    }
}

var num: Int = 0
num.adjust()

print(7.simpleDes)


let protocolValue: ExampleProtocol = a
print(protocolValue.simpleDes)
// print(protocolValue.anotherProperty)  // Uncomment to see the error


let maximumNumberOfLoginAttempts = 10
var currentLoginAttempt = 0
var x = 0, y = 0, z = 0.0


var welcomeMessage: String = "hello"

var red, green, blue: Double

let 你好 = "Hi"

Int8.min
Int8.max
UInt8.min
UInt8.max
uint.min
uint.max
Int8.min + Int8(UInt8.min + 20)

//元组(tuples)把多个值组合成一个复合值。元组内的值可以是任意类型,并不要求是相同类型。

let http404Error = (400, "Not Found")

http404Error.0
http404Error.1

let possibleNumber = "1a23"
let convertedNumber = Int(possibleNumber)


let possibleString: String? = "An optional string."
let forcedString: String = possibleString! // 需要惊叹号来获取值
let assumedString: String! = "An implicitly unwrapped optional string."
let implicitString: String = assumedString // 不需要感叹号

let age = 3
assert(age >= 0, "not true for a people's age")

assert(age >= 0)




    //空🈴运算符  (a ?? b) 将对可选类型 进行空判断,如果a包含一个值就进行解封,否则就返回一个默认值b.这个运算符有两个条件:
    //• 表达式 必须是Optional类型
    //   • 默认值 的类型必须要和 存储值的类型保持一致
    // a != nil ? a! :b

let defaultColorName = "red"
var userDefinedColorName: String?
var colorNameToUse = userDefinedColorName ?? defaultColorName

userDefinedColorName = "green"
colorNameToUse = userDefinedColorName ?? defaultColorName

for index in 1..<5 {
    //1..<5    4
    //1...5    5
    print(index)
}

var emptyString = ""
var anotherEmptyString = String()

if anotherEmptyString.isEmpty {
    print("emptyString is empty")
}

for character in "Dog!?".characters {
    print(character)
}

let exclamationMark: Character = "!"

let catCharacters: [Character] = ["D", "O", "G"]

let catString = String(catCharacters)
emptyString.append(exclamationMark)


let multipliser = 3
let message = "\(multipliser) times 2.5  is \(Double(multipliser) * 2.5)"
let unusualMenagerie = "Dromedary ?"
print("unusualMenagerie has \(unusualMenagerie.characters.count) characters")


let greetting = "Guten Tag!"
greetting[greetting.startIndex]
greetting.startIndex
greetting.endIndex.predecessor()
greetting.startIndex.successor()

greetting.startIndex.advancedBy(2)

greetting.endIndex.predecessor()

greetting.characters.count
greetting.characters.indices

var welcome = "hello"
welcome.insert("!", atIndex: welcome.endIndex.predecessor())

welcome.insert("!", atIndex: welcome.startIndex)

let range = welcome.endIndex.advancedBy(-3)..<welcome.endIndex
welcome.removeRange(range)


welcome.hasPrefix("he")


var someInts = [Int]()

someInts.append(3)



var threeDoubles = [Double](count: 4, repeatedValue:0.0)


var anotherThreeDoubles = Array(count:3, repeatedValue:2.5)


var sixDoubles = threeDoubles + anotherThreeDoubles


var shopLists = ["Eggs", "Milk"]

shopLists.isEmpty
shopLists.append("Four")
shopLists.insert("Three", atIndex: 2)

shopLists.removeAtIndex(1)
shopLists

for (index, value) in shopLists.enumerate() {
    print(index)
    print(value)
}

var letters = Set<Character>()
print("letters is of type Set<Character> with \(letters.count) items")

letters.insert("a")

letters = []

var favoriteGenres:Set<String> = ["Rock", "Hip Pop"]

var favorite: Set = ["Rock", "Hip Pop"]

var namesOfIntegers = [Int: String]()
var emptyDic = [:]

namesOfIntegers[16] = "John"
namesOfIntegers


var airports: [String: String] = ["YYZ": "Toronto Pearson", "DUB": "Dublin"]

if let oldValue = airports.updateValue("Dublin Airport", forKey: "DUB") {
    print("The old value for DUB was \(oldValue).")
}
// 输出 "The old value for DUB was Dublin."

airports.keys

let integerToDescribe = 5
var description = "The number \(integerToDescribe) is"
switch integerToDescribe {
case 2, 3, 5, 7, 11, 13, 17, 19:
    description += " a prime number, and also"
    fallthrough
case 1, 9:
    description += "1"
    fallthrough
default:
    description += " an integer."
}
print(description)

if #available(iOS 9, OSX 10.10,  *) {
    
} else {
    
}


func someFunction(parameterWithDefault: Int = 12) {
    // function body goes here
    // if no arguments are passed to the function call,
    // value of parameterWithDefault is 12
    print(parameterWithDefault)
}
someFunction(6) // parameterWithDefault is 6
someFunction() // parameterWithDefault is 12

func arithmeticMean(numbers: Double...) -> Double {
    var total = 0.0
    for num in numbers {
        total += num
    }
    return total
}

arithmeticMean(1, 3, 5, 7)


func swapTwoInts(inout a: Int, inout _ b: Int) {
    let temporaryA = a
    a = b
    b = temporaryA
}

var someInt = 3
var anotherInt = 107
swapTwoInts(&someInt, &anotherInt)
someInt
anotherInt



func stepForward(input: Int) -> Int {
    return input + 1
}
func stepBackward(input: Int) -> Int {
    return input - 1
}

func chooseStepFunction(backwards: Bool) -> (Int) -> Int {
    return backwards ? stepBackward : stepForward
}

let names = ["Chris", "Alex", "Ewa", "Barry", "Daniella"]
func backwards(s1: String, s2: String) -> Bool {
    return s1 > s2
}
var reversed = names.sort(backwards)

reversed = names.sort({s1, s2 in return s1 < s2})


reversed = names.sort({$0 > $1})

reversed = names.sort(<)

struct Resolution {
    var width = 0
    var height = 0
}

class VideoMode {
    var resolution = Resolution()
    var interlaced = false
    var frameRate = 0.0
    var name: String?
}

extension Array where Element: Comparable {
    func countUniques() -> Int {
        let sorted = sort(<)
        let initial: (Element?, Int) = (.None, 0)
        let reduced = sorted.reduce(initial) { ($1, $0.0 == $1 ? $0.1 : $0.1 + 1) }
        return reduced.1
    }
}




func areTheyEqual<T: Equatable>(x: T, _ y: T) ->Bool {
    return x == y
}

class Star {
    class func spin() {}
    static func illuminate() {}
}
class Sun : Star {
    override class func spin() {
        super.spin()
    }
//    override static func illuminate() { // error: class method overrides a 'final' class method
//        super.illuminate()
//    }
}





