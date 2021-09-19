import UIKit

/**
 1. Напишите расширение для коллекций целых чисел, которое возвращает,
 сколько раз определенная цифра фигурирует в любом из его номеров.

  Код [5, 15, 55, 515].testFunc(count: "5") должен возвращать 6.
  Код [5, 15, 55, 515].testFunc(count: "1") должен возвращать 2.
  Код [55555].testFunc(count: "5") должен возвращать 5
  Код [55555].testFunc(count: "1") должен возвращать 0.
 */
extension Array {
    func testFunc (count: String) -> Int {
        var result: Int = 0
        var tmpElement: Int
        for element in self {
            tmpElement = element as! Int
            repeat {
                if tmpElement % 10 == Int(count) {
                    result += 1
                }
                tmpElement /= 10
            } while tmpElement > 0
        }
        return result
    }
}
var test1 = [5,2,5,2,4,33,1555].testFunc(count: "5")
var test2 = [5, 15, 55, 515].testFunc(count: "1")
var test3 = [55555].testFunc(count: "5")
var test4 = [55555].testFunc(count: "1")

print("Task #1")
print(test1)
print(test2)
print(test3)
print(test4)


/**
 2. Отсортировать массив по длине строк его значений

 ["a", "abc", "ab"].testSorted() должен возвращать ["abc", "ab", "a"].
 */
extension Array {
    func testSorted() -> [String] {
        var result = self as! [String]
        // используем скучную, но надежную xD пузырьковую сортировку
        for i in 0 ..< result.count - 1 {
            for j in 0 ..< result.count-i-1 {
                if result[j] < result[j+1] {
                    let temp = result[j + 1]
                    result[j + 1] = result[j]
                    result[j] = temp
                    // swapAt(j, j+1)  // Как я понял она не работает, потому что еще не определена
                }
            }
        }
        return result
        // return self.sorted(by: >) // Вопрос: в расширениях функции высшего порядка не вызываются потому что они еще не определены?
    }
}

var test5 = ["a", "abc", "ab"].testSorted()
print("Task #2")
print(test5)



/**
 3. Создайте функцию, которая принимает массив несортированных чисел от 1 до 100,
 где ноль или более чисел могут отсутствовать, и возвращает массив отсутствующих чисел например: 

 var testArray = Array(1...100)
 testArray.remove(at: 25)
 testArray.remove(at: 20)
 testArray.remove(at: 6)

 getMissingNumbers(input: testArray) // [7, 21, 26]
 */

var testArray = Array(1...100)
testArray.remove(at: 25)
testArray.remove(at: 20)
testArray.remove(at: 6)

func getMissingNumbers(input: [Int]) -> [Int] {
    let setArray: Set = Set(Array(1...100))
    let result = Array(setArray.subtracting(Set(input))).sorted(by: <)
    return result
}
var test6 = getMissingNumbers(input: testArray)

print("Task #3")
print(test6)
/**
 4. Поменять значения массива местами (не использовать reverse)
 Пример:
 var array = [1, 2, 3]
 array.testReverse()

 */

extension Array {
    func testReverse() -> [Int] {
        var result = self as! [Int]
        for i in 0 ..< (result.count / 2) {
            let temp = result[i]
            result[i] = result[result.count - 1 - i]
            result[result.count - 1 - i] = temp
        }
        return result
    }
}

var array = [1, 2, 3]
let test7 = array.testReverse()
print("Task #4")
print(test7)


/**
 Решите проблему сильных ссылок
 */

class Person {
  let name: String
  let email: String
  var car: Car? // либо же мы можем добавить weak сюда, но как я понимаю, хороший тон - это ослаблять ссылки у потомков. Если неправ, прошу поправить

  init(name: String, email: String) {
    self.name = name
    self.email = email
  }

  deinit {
    print("Goodbye \(name)!")
  }
}

class Car {
  let id: Int
  let type: String
  weak var owner: Person? // ослабил ссылку

 init(id: Int, type: String) {
   self.id = id
   self.type = type
 }
    
    deinit {
        print("Goodbye \(type)!")
    }
}

var owner: Person? = Person(
    name: "Cosmin",
    email: "cosmin@whatever.com"
)
var car: Car? = Car(id: 10, type: "BMW")

owner?.car = car
car?.owner = owner

print("Task #5")
owner = nil
car = nil

print("Thanks for this Home Work. It was quite interesting")
