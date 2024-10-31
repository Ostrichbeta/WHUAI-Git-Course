// 協定的定義
enum Engine { case GASONLINE, DIESEL }
protocol Car {
    var wheels: Int { get }
    var fuelCapacity: Double { get }
    var engine: Engine { get }
    var seats: Int { get }
    
    init(_ wheels: Int, 
         _ fuelCapacity: Double,
         _ engine: Engine,
         _ seats: Int)
    func run(distance: Double) -> Double
}

class Sedan: Car {
    let wheels: Int; let fuelCapacity: Double
    let engine: Engine; let seats: Int
    var odometer: Double = 0
    required init(_ wheels: Int, _ fuelCapacity: Double, _ engine: Engine, _ seats: Int) {
        self.wheels = wheels; self.fuelCapacity = fuelCapacity
        self.engine = engine; self.seats = seats
    }
    func run(distance: Double) -> Double {
        odometer += distance
        return distance
    }
}

let myCar = Sedan(4, 30, .GASONLINE, 5)
myCar.run(distance: 10)
myCar.odometer