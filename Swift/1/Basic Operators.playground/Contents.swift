let b = 10
var a = 5
a = b

1 + 2       // equals 3
5 - 3       // equals 2
2 * 3       // equals 6
10.0 / 2.5


let helloWorld = "hello, " + "world"  // equals "hello, world"
print(helloWorld)

let x = 9 % 4
if (b % a) == 0 {
    print("ss")
}

let three = 3
let minusThree = -three       // minusThree equals -3
let plusThree = +minusThree

let name = "aaaaa"
if name == "world" {
    print("hello, world")
} else {
    print("I'm sorry \(name), but I don't recognize you")
}


let contentHeight = 40
let hasHeader = false

var rowHeight: Int = (hasHeader ? 100 : 50)
if hasHeader {
    rowHeight = 100
}else{
    rowHeight = 50
}

for index in 1...3 {
    print("\(index) times 2 is \(index * 2)")
}


var animals: Array<String>
animals = ["Snake", "Cow", "Dog", "Mouse", "Mouse"]
animals.append("Zebra")
animals.remove(at: 0)
//animals.removeLast()
//animals.removeAll()
//animals.first!
//animals.last


//print(animals[2])

animals.forEach { (animal) in
//    print(animal)
}
for animal in animals {
//    print(animal)
}

if animals.isEmpty {
    
}

// Looking for Zebra
let searchString = "Cow"
let indexOfSearch = animals.index(of: searchString)

if indexOfSearch != nil {
    print("We have the \(searchString), with the index of \(indexOfSearch!)")
    print(animals[indexOfSearch!])
}else{
    print("We don't have it")
}


var animalsSet: Set<String>
animalsSet = ["Snake", "Cow", "Dog", "Mouse", "Mouse"]
print(animals.count)
print(animalsSet.count)

if animalsSet.contains("Snake") {
    print("has snake")
}
