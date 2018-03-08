import Foundation

// Classes

class SomeClass {
    //
}

struct SomeStruct {
    
}


struct Resolution {
    var width: Int
    var height: Int
}

class VideoMode {
    
    enum Quality {
        case hd
        case quadHD
    }
    
    enum VideoModeError: Error {
        case unkownQuality
        case checkFailed
    }
    
    var currentQuality = Quality.hd
    var resolution = Resolution(width: 50, height: 50)
    
    var interlaced: Bool
    var frameRate: Double
    var name: String
    
    init(name: String, frameRate: Double, interlaced: Bool) {
        self.name = name
        self.frameRate = frameRate
        self.interlaced = interlaced
    }
    
    func exampleA() -> Int {
        return 10
    }
    
    func updateQuality() throws -> VideoMode.Quality {
//        guard frameRate > 10 else {
//            throw VideoModeError.unkownQuality
//        }
//
//        guard name == "SSS" else {
//            throw VideoModeError.unkownQuality
//        }
//
//        guard frameRate > 10 && name == "SSS" else {
//            throw VideoModeError.unkownQuality
//        }
//
//
//        if frameRate > 10 {
//            if name == "SSS" {
//                // do something
//
//            }
//        }

        guard frameRate > 50 && interlaced else {
            throw VideoModeError.unkownQuality
        }
        
        return .hd
    }
    
    func checkStuff() throws {
        guard let xx = try? updateQuality() else {
            throw VideoModeError.checkFailed
        }
        
        let something = "Name"
        try updateQuality()
    }
}

extension VideoMode {
    func exampleA() -> String {
        return "example"
    }
}

//
//
//let x = VideoMode(name: "dsa", frameRate: 100, interlaced: false)

//do {
//    try x.checkStuff()
//} catch let err {
//    print(err)
//}
//
//do {
//    let xx = try x.updateQuality()
//} catch let err {
//    print("failed with error: \(err)")
//}


extension String {
    func giveSomethingBack() -> String {
        return self + "Func"
    }
    
    static func giveAnotherThingBack() -> String {
        return "AnotherThing"
    }
}

let ss = "Something"
ss.giveSomethingBack()
String.giveAnotherThingBack()

protocol SomeProtocol {
    var height: Int { get set }
    var width: Int { get set }
    func someFunc()
}

class A: SomeProtocol {
    var height: Int {
        return 20
    }
    
    var width: Int {
        return 10
    }
    
    func someFunc() {
        //
    }
}

let aa = A()
