/*
 A. A+B 1
 Ограничение времени    2 секунды
 Ограничение памяти    64Mb
 Ввод    стандартный ввод или input.txt
 Вывод    стандартный вывод или output.txt
 Даны два числа
 A и B.
 Вам нужно вычислить их сумму
 A + B.
 В этой задаче для работы с входными и выходными данными вы можете использовать и файлы и потоки на ваше усмотрение.

 Формат ввода
 Первая строка входного файла содержит числа A и B (-2 ⋅ 109 ≤ A, B ≤ 2 ⋅ 109) разделенные пробелом

 Формат вывода
 В единственной строке выхода выведите сумму чисел
 A + B

 Пример 1
 Ввод    Вывод
 2 2
 4
 Пример 2
 Ввод    Вывод
 57 43
 100
 Пример 3
 Ввод    Вывод
 123456789 673243342
 796700131

 */
import PlaygroundSupport

PlaygroundPage.current.needsIndefiniteExecution = true

func aSum(_ input: String?) -> String? {

    guard let input = input else { return nil }

    var first = ""
    var second = ""

    var charIsA = true
    input.forEach { (char) in
        if charIsA {
            if char == " " {
                charIsA = false
                return
            }
            first.append(char)
        } else {
            second.append(char)
        }
    }

    guard let a = Int(first) else { return nil }
    guard let b = Int(second) else { return nil }

    let check = 10*10*10*10*10*10*10*10*10

    if a > 2 * check || a < -2 * check { return nil }
    if b > 2 * check || b < -2 * check { return nil }

    print(input)
    print(String(a + b))

    return String(a + b)
}

//aSum("2 2")
//aSum("57 43")
//aSum("123456789 673243342")
//aSum("-123456789 -673243342")

/*

 B. A+B 2
 Ограничение времени    2 секунды
 Ограничение памяти    64Mb
 Ввод    input.txt
 Вывод    output.txt
 Даны два числа A и B. Вам нужно вычислить их сумму A+B. В этой задаче вам нужно читать из файла и выводить ответ в файл

 Формат ввода
 Первая строка входного файла содержит числа A и B (-2 ⋅ 109 ≤ A, B ≤ 2 ⋅ 109) разделенные пробелом

 Формат вывода
 В единственной строке выходного файла выведите сумму чисел A+B
 */

//-------------------

import Foundation //import pod for use Bundle.main.path - read and write / file
func bSum() {

    var input = [String]()

    if let path = Bundle.main.path(forResource: "inputF", ofType: "txt") {
        if let inputF = try? String(contentsOfFile: path) {
            print(inputF)
            input = inputF.components(separatedBy: " ")
        }
    }

    if input.count != 2 { return }

    var first = ""
    var second = ""

    input[0].forEach { (char) in
        if Int(String(char)) != nil {
            first.append(char)
        }
    }

    input[1].forEach { (char) in
        if Int(String(char)) != nil {
            second.append(char)
        }
    }

    guard var a = Int(first) else { return }
    guard var b = Int(second) else { return }

    if input[0].first == "-" {
        a = -a
    }

    if input[1].first == "-" {
        b = -b
    }

    let check = 10*10*10*10*10*10*10*10*10

    if a > 2 * check || a < -2 * check { return }
    if b > 2 * check || b < -2 * check { return }

    let out = String(a + b)
    print(out)

    if let path = Bundle.main.path(forResource: "outputF", ofType: "txt") {
        do {
            try out.write(toFile: path, atomically: true, encoding: .utf8)
            print("success")
        } catch {
            //Ошибка записи в файл ...
            print("error")
            return
        }
    }
}

//bSum()

//----------------------------

/*

 Предпологаю что ошибка в приеме моих работ системой кроется в не првильной интерплетации мною требований по вводу и выводу данных. Как это реализовать по другому, что бы подходило в рамках данной системы, я, увы, не смог найти решения в отведенное время. Ниже эксперементирую с вводом текста через консоль Swift Playground, но данные методы не дают результата.

 Пишу наверное что бы было понятно чем я был занят всё время отведенное на решение задач =/
 */

//test Input with console - 1
func inputTestOne() -> String {
    let keyboard = FileHandle.standardInput
    let inputData = keyboard.availableData
    print(NSString(data: inputData, encoding:String.Encoding.utf8.rawValue)! as String)
    return NSString(data: inputData, encoding:String.Encoding.utf8.rawValue)! as String
}

//test Input with console - 2
func inputTestTwo() -> String {
    let keyboard = FileHandle.standardInput
    let input = keyboard.availableData
    print(String(data: input, encoding: .utf8) ?? "Damn!")
    return String(data: input, encoding: .utf8) ?? "Damn!"
}

//test Input with console - 3
func inputTestThree(max:Int = 8192) -> String? {
    assert(max > 0, "max must be between 1 and Int.max")

    var buf:Array<CChar> = []
    var c = getchar()
    while c != EOF && c != 10 && buf.count < max {
        buf.append(CChar(c))
        c = getchar()
    }

    //always null terminate
    buf.append(CChar(0))

    return buf.withUnsafeBufferPointer {
        String(cString: $0.baseAddress!)
    }
}

//inputTestOne()
//inputTestTwo()
//inputTestThree()


// --------------------------------------

// another test

func test() {
    guard let input = readLine() else { return }

    var first = ""
    var second = ""

    var charIsA = true
    input.forEach { (char) in
        if charIsA {
            if char == " " {
                charIsA = false
                return
            }
            first.append(char)
        } else {
            second.append(char)
        }
    }

    guard let a = Int(first) else { return }
    guard let b = Int(second) else { return }

    let check = 10*10*10*10*10*10*10*10*10

    if a > 2 * check || a < -2 * check { return }
    if b > 2 * check || b < -2 * check { return }

    print(String(a + b))
}

//test()

//print(Int.max)
//print(10*10*10*10*10*10*10*10*10*2)

//A - OK / C - OK
func test2() {
    guard let data = readLine()?.split(separator: " ").map({ Int(String($0)) }) else { return }

    var input = [Int]()
    data.forEach { (element) in
        guard let num = element else { return }
        input.append(num)
    }

    if input.count != 2 { return }

    let check = 10*10*10*10*10*10*10*10*10

    if input[0] > 2 * check || input[0] < -2 * check { return }
    if input[1] > 2 * check || input[1] < -2 * check { return }

    print(input[0] + input[1])
}

//B

//import Foundation

func saveToFile(_ string: String) {
    let url = getDocumentsDirectory().appendingPathComponent("output.txt")

    do {
        try string.write(to: url, atomically: true, encoding: String.Encoding.utf8)
    } catch {
        // failed to write file
    }
}

func readFromFile() -> String? {
    let url = getDocumentsDirectory().appendingPathComponent("input.txt")

    do {
        let input = try String(contentsOf: url, encoding: .utf8)
        return input
    } catch {
        // failed read file
        return nil
    }
}

func getDocumentsDirectory() -> URL {
    let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
    return paths[0]
}

func bTest() {
    guard let data = readFromFile()?.split(separator: " ").map({ Int($0) }) else { return }

    var input = [Int]()
    data.forEach { (element) in
        guard let num = element else { return }
        input.append(num)
    }

    if input.count != 2 { return }
    let check = 10*10*10*10*10*10*10*10*10

    if input[0] > 2 * check || input[0] < -2 * check { return }
    if input[1] > 2 * check || input[1] < -2 * check { return }

    saveToFile(String(input[0] + input[1]))
}

func imitationWrite(_ string: String) {
    let url = getDocumentsDirectory().appendingPathComponent("input.txt")

    do {
        try string.write(to: url, atomically: true, encoding: String.Encoding.utf8)
    } catch {
        // failed to write file
    }
}

func imitationRead() -> String? {
    let url = getDocumentsDirectory().appendingPathComponent("output.txt")

    do {
        let input = try String(contentsOf: url, encoding: .utf8)
        return input
    } catch {
        // failed read file
        return nil
    }
}

//imitationWrite("-24 -12")
//bTest()
//print(imitationRead())


func bTest2() {

    guard let path = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else { return }

    let inputURL = path.appendingPathComponent("input.txt")
    var input = [Int]()

    do {
        let data = try String(contentsOf: inputURL, encoding: .utf8)
        data.split(separator: " ").map { Int($0) }.forEach {
            guard let num = $0 else { return }
            input.append(num)
        }
    } catch {
        // failed read file
        return
    }

    if input.count != 2 { return }
    let check = 10*10*10*10*10*10*10*10*10

    if input[0] > 2 * check || input[0] < -2 * check { return }
    if input[1] > 2 * check || input[1] < -2 * check { return }

    let outputURL = path.appendingPathComponent("output.txt")

    do {
        try String(input[0] + input[1]).write(to: outputURL, atomically: true, encoding: .utf8)
        return
    } catch {
        // failed to write file
        return
    }
}

imitationWrite("-24 -12")
bTest2()
imitationRead()


import Foundation
func bTest3() {

    freopen("./input.txt", "r", stdin)
    guard let data = readLine() else { return }

    var input = [Int]()
    data.split(separator: " ").map { Int($0) }.forEach {
        guard let num = $0 else { return }
        input.append(num)
    }

    if input.count != 2 { return }
    let check = 10*10*10*10*10*10*10*10*10

    if input[0] > 2 * check || input[0] < -2 * check { return }
    if input[1] > 2 * check || input[1] < -2 * check { return }

    freopen("./output.txt", "w", stdout)
    print(input[0] + input[1], terminator: "")
}

bTest3()

//var k = pow(10, 35)
//k.description
