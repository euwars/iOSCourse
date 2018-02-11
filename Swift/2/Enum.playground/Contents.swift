func function(name: String) -> Int {
    if name == "Farzad" {
        return 10
    } else if name == "Farzad2" {
        return 11
    } else if name == "Farzad 3" {
        return 12
    } else {
        return 100
    }
}


function(name: "Farzad3")


enum Time {
    case day(Int, Int, Int)
    case night
}

enum Arrow {
    case left
    case right
    case up
    case down
}

enum AnotherTime: Int {
    case day = 12
    case night = 13
}

let z = AnotherTime(rawValue: 13)

func anotherXX(anotherTime: AnotherTime) {
    print(anotherTime.rawValue)
//
//    switch anotherTime {
//    case .day:
//        print(anotherTime.rawValue)
//    case .night:
//        print(anotherTime.rawValue)
//    }
}



anotherXX(anotherTime: AnotherTime.night)


func xx(time: Time) -> Int {
    switch time {
    case .day:
        return 10
    case .night:
        return 12
    }
}

xx(time: .day(10, 10, 10))


enum NameEnum {
    case farzad(String)
    case farzad2
    case farzad3
}

func anotherFunction(name: NameEnum) -> Int {
    switch name {
    case .farzad, .farzad2:
        
        return 10
    case .farzad3:
        return 12
    }

//    if name == .farzad {
//        return 10
//    }else if name == .farzad2 {
//        return 11
//    }else if name == .farzad3 {
//        return 12
//    } else {
//        return 100
//    }
}

anotherFunction(name: NameEnum.farzad2)
