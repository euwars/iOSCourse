let x = ["Text3", "Text", "Text2", "Text3"]
let y = [1, 2, 3, 4]
let z = [x, y] as [Any]

let xx = Set(x)

var dict: Dictionary<String, Any> = ["key1": 1234, "key2": "value2"]
//var dict = ["key1": 123, "key2": "value2"] as [String : Any]
//dict["key1"] = "value3"
let value1 = dict["key1"]
dict.count
dict.forEach { (obj) in
}

for (key, value) in dict {
    print(key)
}

for i in 1..<10 {
    print(i)
}


let finalSquare = 5
var square = 0


//repeat {
//    // move up or down for a snake or ladder
//    square += 1
//    print("Adding to squre")
//} while square < finalSquare


//var num1 = 5
//
//if num1 == 1 {
//    print("Value is either 1, 3, 5")
//} else if num1 == 2 {
//    print("Value is 2")
//
//} else if num1 == 10 {
//    print("Value is 10")
//} else {
//    print("We are not tracking")
//}
//
//switch num1 {
//case 1, 3, 5:
//    print("Value is either 1, 3, 5")
//case 2:
//    print("Value is 2")
//case 10:
//    print("Value is 10")
//default:
//    print("We are not tracking")
//}
//
//
//func function(One str: String) {
//
//}
//
//func function(Two str: String) {
//
//}


func someFunc(str: String?, integer: Int = 10, str2: String? = nil) {
    if let str = str {
        var stringToSave = str
        print("print \(str) \(integer), and str2 is: \(str2)")
    }
}

var xxxx = "Another thing"

someFunc(str: nil)
someFunc(str: xxxx, integer: 20, str2: "string 2")



func calculateHeight(base: Int) -> Int? {
    let result = base * 2
    if result > 10 {
        return result
    }
    return nil
}

func sayHelloWorld(name: String?) -> (String, String, Int)? {
    if let str = name {
        return ("String1", "String2", 3)
    }
    return nil
}

func functionToReturnBool(name: String) -> Any {
    if name == "Something" {
        return true
        print(name)
    }
    return false
}


func root() -> Int{
    func add(val: Int) -> Int {
        return val + 10
    }
    
    func multiply(val: Int) -> Int {
        return val * 10
    }
    
    let baseNumber = 5
    
    let addedNumber = add(val: baseNumber)
    let multiplyed = multiply(val: addedNumber)
    return multiplyed
}

//root()
let _ = root()

