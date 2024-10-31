// 擴展計算屬性
extension Double {
    var km: Double { return self * 1_000.0 }
    var m: Double { return self }
    var cm: Double { return self / 100.0 }
    var mm: Double { return self / 1_000.0 }
    var ft: Double { return self / 3.28084 }
}
let oneInch = 25.4.mm
print("One inch is \(oneInch) meters")
// Prints "One inch is 0.0254 meters"
let threeFeet = 3.ft
print("Three feet is \(threeFeet) meters")
// Prints "Three feet is 0.914399970739201 meters"


// 擴展初始化器原始代碼
enum Engine { case GASONLINE, DIESEL }
class Car {
    let wheels: Int; let fuelCapacity: Double
    let engine: Engine; let seats: Int
    
    init(wheels: Int, fuelCapacity: Double, engine: Engine, seats: Int) {
        self.wheels = wheels
        self.fuelCapacity = fuelCapacity
        self.engine = engine
        self.seats = seats
    }
}

//擴展初始化器
extension Car {
    convenience init(fuelCapacity: Double) {
        self.init(wheels: 2, 
                  fuelCapacity: fuelCapacity,
                  engine: .GASONLINE, 
                  seats: 5)
    }
}

let mySimpleCar = Car(fuelCapacity: 30)

//擴展初始化器
extension Car {
    func run(distance: Double) {
       print("Ran for \(distance) miles.")
    }
}
let mySimpleCar2 = Car(fuelCapacity: 40)
mySimpleCar2.run(distance: 20) // Ran for 20.0 miles.

// 擴展下標
extension String {
    subscript(index: Int) -> String {
        return String(self[self.index(self.startIndex, offsetBy: index)..<self.index(startIndex, offsetBy: index + 1)])
    }
}

"sadsad"[2] // d