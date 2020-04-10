//    freopen("./input.txt", "r", stdin)
import Foundation

func matrix() {

    guard let input = readLine() else { return }
    guard let count = Int(input) else { return }
    if count < 2 || count > 100 { return }

    var matrix = [[Int]]()

    var values = Set<Int>()
    for index in 1...(count * count) {
        values.insert(index)
    }

    for index in 0..<count {
        guard let numStr = readLine() else { return }
        numStr.split(separator: " ").map { Int($0) }.forEach {
            guard let num = $0 else { return }
            matrix[index].append(num)
            values.remove(num)
        }
    }

    var output = [String]()

    for line in 0..<count {
        var lineStr = String()
        for column in 0..<count {
            if matrix[line][column] == 0 {
                matrix[line][column] = values.removeFirst()
            }

            if column == count - 1 {
                lineStr.append(String(matrix[line][column]))
            } else {
                lineStr.append(String(matrix[line][column]) + " ")
            }
        }
        output.append(lineStr)
    }

    for index in 0..<count {
        if index != count - 1 {
            print(output[index])
        } else {
            print(output[index], terminator: "") }
    }
}

//
//freopen("./output.txt", "w", stdout)

//matrix()

//    freopen("./output.txt", "w", stdout)
//    print(input[0] + input[1], terminator: "")


//Errors :

import Foundation

func serverResponse() {

    guard let nStr = readLine() else { return }
    guard let n = Int(nStr) else { return }
    if n < 1 || n > 50000 { return }

    var setOfN = Set<Int>()
    guard let valuesN = readLine() else { return }
    valuesN.split(separator: " ").map { Int($0)}.forEach {
        guard let num = $0 else { return }
        setOfN.insert(num)
    }

    guard let mStr = readLine() else { return }
    guard let m = Int(mStr) else { return }
    if m < 1 || m > 50000 { return }

    var arrayOfM = Array(repeating: (-1, -1), count: m)
    for index in 0..<m {
        guard let bStr = readLine() else { return }
        guard let b = Int(bStr) else { return }
        arrayOfM[index].0 = b
        if setOfN.contains(b) {
            arrayOfM[index].1 = b
        } else {
            var valueFinded = false
            var range = 1
            while !valueFinded {
                if setOfN.contains(b - range) {
                    arrayOfM[index].1 = b - range
                    valueFinded = true
                    return
                } else if setOfN.contains(b + range) {
                    arrayOfM[index].1 = b + range
                    valueFinded = true
                    return
                }
                range += 1
            }
        }
    }

    for index in 0..<m {
        if index == m - 1 {
            print(arrayOfM[index].1, terminator: "")
        } else {
            print(arrayOfM[index].1)
        }
    }
}

serverResponse()

import Foundation

func arch() {

    guard let lineStr = readLine() else { return }
    if lineStr == "" || lineStr.count > 1000000 { return }

    var output = [String]()
    var prefixSet = Set<String>()

    var p = ""

    lineStr.forEach {
        p.append($0)
        if !prefixSet.contains(p) {
            output.append(p)
            prefixSet.insert(p)
            p = ""
        }
    }

    if p != "" {
        output.append(p)
    }

    for index in 0..<output.count {
        if index == output.count - 1 {
            print(output[index], terminator: "")
        } else {
            print(output[index], terminator: " ")
        }
    }
}

//arch()

//import Foundation
//
//func findSupervisors() {
//
//    guard let nStr = readLine() else { return }
//    guard let n = Int(nStr) else { return }
//    if n < 1 || n > 200000 { return }
//
//    var employees = [Int]()
//    guard let data = readLine() else { return }
//    data.split(separator: " ").map { Int($0)}.forEach {
//        guard let employee = $0 else { return }
//        employees.append(employee)
//    }
//
//    if employees.count != n { return }
//
//    var output = [Int]()
//    for index in 0..<n {
//        var supervisors = 0
//        var newIndex = index
//        var directorIsFind = false
//        while !directorIsFind {
//            if employees[newIndex] != 0 {
//                supervisors += 1
//                newIndex = employees[newIndex]
//            } else {
//                directorIsFind = true
//            }
//        }
//
//        output.append(supervisors)
//    }
//
//    for index in 0..<n {
//        if index == n - 1 {
//            print(output[index], terminator: "")
//        } else {
//            print(output[index], terminator: " ")
//        }
//    }
//}
//
//findSupervisors()


import Foundation

func findSupervisors() {

    let n = Int(readLine()!)!
    var employees = [Int]()
    readLine()!.split(separator: " ").map { Int($0)}.forEach {
        employees.append($0!)
    }

    var cheat = Array(repeating: -1, count: n)

    for index in 0..<n {
        var supervisors = 0
        var newIndex = index
        var directorIsFind = false
        while !directorIsFind {
            if cheat[newIndex] != -1 {
                directorIsFind = true
                supervisors += cheat[newIndex]
                return
            }
            if employees[newIndex] != 0 {
                supervisors += 1
                newIndex = employees[newIndex]
            } else {
                directorIsFind = true
            }
        }
        cheat[index] = supervisors

        if index != n - 1 {
            print(supervisors, terminator: " ")
        } else {
            print(supervisors, terminator: "")
        }
    }
}

//findSupervisors()
