import UIKit

// Класс дом
class House {
    var windows: String?
    var doors: String?
    var rooms: Int?
    var hasGarage: Bool?
    // ...
}

// Протокол, для установки параметров дома
protocol Builder {
    func reset()
    
    func setWindows()
    func setDoors()
    func setRooms()
    func setHasGarage()
    
    func getResult() -> House
}

// Билдер для коттеджа
class CottageBuilder: Builder {
    
    var house: House = House()
    
    func reset() {
        self.house = House()
    }
    
    func setWindows() {
        house.windows = "Plastic"
    }
    
    func setDoors() {
        house.doors = "Old red oak"
    }
    
    func setRooms() {
        house.rooms = 8
    }
    
    func setHasGarage() {
        house.hasGarage = true
    }
    
    func getResult() -> House {
        return house
    }
    
}

// Билдер для обычного дома (оставил пару параметров не установленными)
class OrdinaryHouseBuilder: Builder {
    
    var house: House = House()
    
    func reset() {
        self.house = House()
    }
    
    func setWindows() {
        house.windows = "Glass"
    }
    
    func setDoors() {
        // nothing
    }
    
    func setRooms() {
        house.rooms = 2
    }
    
    func setHasGarage() {
        // nothing
    }
    
    func getResult() -> House {
        return house
    }
    
    
}

// Добавляем паттерн Директор, для создания дома

class Director {
    private var builder: Builder
    
    init(builder: Builder) {
        self.builder = builder
    }
    
    func setBuilder(builder: Builder) {
        self.builder = builder
    }
    
    func createHouse() -> House {
        self.builder.reset()
        
        self.builder.setWindows()
        self.builder.setDoors()
        self.builder.setRooms()
        self.builder.setHasGarage()
        
        return self.builder.getResult()
    }
}

// объект класса коттедж
var cottageBuilder = CottageBuilder()

// объект класса директор, в котором сразу установили коттедж
var director = Director(builder: cottageBuilder)
director.createHouse().windows

// переобределяем директора на стандартный дом
var ordinaryHouseBuilder = OrdinaryHouseBuilder()
director.setBuilder(builder: ordinaryHouseBuilder)
director.createHouse().windows


// Вопрос, можно ли оставлять некоторе параметры не установленными как в строчках 69 и 77 или это делается по другому?

// Литература
// https://refactoring.guru/ru/design-patterns/builder
// https://www.youtube.com/watch?v=RvbKZ3v66m8&list=PLcmaZSNs2TKgGHZ38xh-PaHkCUrehijg1&index=13
