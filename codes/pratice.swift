class Person {
    var name: String
    var age: Int
    var city: String
    
    init(name: String, age: Int, city: String) {
        self.name = name
        self.age = age > 0 ? age : 0
        self.city = city
    }
    
    convenience init(name: String, age: Int) {
        self.init(name: name, age: age, city: "Wuhan")
    }
}

let siuming = Person(name: "Siu Ming", age: -5)