import UIKit

// Table
protocol Table {
    var size: Double? { get set }
    var legsCount: Int? { get set }
    func DatailedInfo()
}

class RoomTable: Table {
    var size: Double?
    var legsCount: Int?
    func DatailedInfo() { print("It's coffe table") }
}

class KitchenTable: Table {
    var size: Double?
    var legsCount: Int?
    func DatailedInfo() { print("It's kitchen table") }
}

// Chair
protocol Chair {
    var size: Double? { get set }
    var material: String? { get set }
}

class RoomChair: Chair {
    var size: Double?
    var material: String?
}

class KitchenChair: Chair {
    var size: Double?
    var material: String?
}

// Abstract Factory
protocol AbstractFactory {
    func createTable() -> Table
    func createChair() -> Chair
}

class RoomFactory: AbstractFactory {
    func createTable() -> Table {
        return RoomTable()
    }
    func createChair() -> Chair {
        return RoomChair()
    }
}

class KitchenFactory: AbstractFactory {
    func createTable() -> Table {
        return KitchenTable()
    }
    func createChair() -> Chair {
        return KitchenChair()
    }
}

var factory: AbstractFactory?

if (true) { // если запрос на мебель для кухни
    factory = KitchenFactory()
} else {
    factory = RoomFactory()
}

var table: Table?
var chair: Chair?

table = factory!.createTable()
chair = factory!.createChair()



// Литература
// https://refactoring.guru/ru/design-patterns/abstract-factory
// https://www.youtube.com/watch?v=0ZinY5GbL-c
