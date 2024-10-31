// 逐一成員初始化器

enum Engine {
case GASONLINE, DIESEL
}

struct Car {
    let wheels: Int
    let fuelCapacity: Double
    let engine: Engine
    let seats: Int
}

let myCar = Car(wheels: 4,
                fuelCapacity: 47,
                engine: .GASONLINE,
                seats: 5)

// 類的預設初始化器
class Car {
    let wheels: Int = 4
    let fuelCapacity: Double = 47.0
    let engine: Engine = .GASONLINE
    let seats: Int = 5
}

let myCar = Car()

// 為類指定初始化器
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
let myCar = Car(wheels: 4, fuelCapacity: 47, 
                engine: .GASONLINE, seats: 5)

// 初始化器多載
class Car {
    let wheels: Int; let fuelCapacity: Double
    let engine: Engine; let seats: Int
    
    init(wheels: Int, fuelCapacity: Double, engine: Engine, seats: Int) {
        self.wheels = wheels; self.fuelCapacity = fuelCapacity
        self.engine = engine; self.seats = seats
    }
    init() {
        (wheels, fuelCapacity, engine, seats) = (4, 30.0, .GASONLINE, 5)
    }
}
let myCar = Car()

// 結構體使用代理
enum Engine { case GASONLINE, DIESEL }

enum CarType { case BUS, SEDAN, TRICYCLE }

struct Car {
    let wheels: Int; let fuelCapacity: Double
    let engine: Engine; let seats: Int
    
    init(_ wheels: Int, _ fuelCapacity: Double, _ engine: Engine, _ seats: Int) {
        self.wheels = wheels
        self.fuelCapacity = fuelCapacity
        self.engine = engine
        self.seats = seats
    }
    
    init(carType: CarType) {
        switch (carType) {
        case .BUS:
            self.init(6, 120, .DIESEL, 20)
        case .SEDAN:
            self.init(4, 50, .GASONLINE, 5)
        case .TRICYCLE:
            self.init(3, 20, .GASONLINE, 5)
        }
    }
}

let myCar = Car(carType: .SEDAN)

// 類使用便捷初始化器
enum Engine { case GASONLINE, DIESEL }

enum CarType { case BUS, SEDAN, TRICYCLE }

class Car {
    let wheels: Int; let fuelCapacity: Double
    let engine: Engine; let seats: Int
    
    init(_ wheels: Int, _ fuelCapacity: Double, _ engine: Engine, _ seats: Int) {
        self.wheels = wheels
        self.fuelCapacity = fuelCapacity
        self.engine = engine
        self.seats = seats
    }
    
    convenience init(carType: CarType) {
        switch (carType) {
        case .BUS:
            self.init(6, 120, .DIESEL, 20)
            
        case .SEDAN:
            self.init(4, 50, .GASONLINE, 5)
            
        case .TRICYCLE:
            self.init(3, 20, .GASONLINE, 5)
        }
    }
}

let myCar = Car(carType: .SEDAN)

// 重寫初始化器（重寫前）
enum Engine { case GASONLINE, DIESEL }
class Car {
    let wheels: Int; let fuelCapacity: Double
    let engine: Engine; let seats: Int
    init(_ wheels: Int, _ fuelCapacity: Double, _ engine: Engine, _ seats: Int) {
        self.wheels = wheels
        self.fuelCapacity = fuelCapacity
        self.engine = engine
        self.seats = seats
    }
    convenience init() { self.init(2, 10, .GASONLINE, 2) }
}
let myCar = Car()

// 如果改寫指定初始化器以及便捷初始化器
class Sedan: Car {
    override init(_ wheels: Int, _ fuelCapacity: Double, _ engine: Engine, _ seats: Int) {
        super.init(wheels < 4 ? 4 : wheels, fuelCapacity, engine, seats < 5 ? 5 : seats)
    }
    convenience init() {
        self.init(4, 20, .GASONLINE, 5)
    }
}

let myCar = Sedan(0, 40, .DIESEL, 3)
let defaultCar = Sedan()
