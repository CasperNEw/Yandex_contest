/*
 Тимбилдинг — весёлое сплочающее мероприятие. Коллеги активно участвуют в конкурсах, квестах, вместе преодолевают игровые трудности. Подчас люди так увлекаются, что реорганизовать их для какой-то новой активности довольно сложно. Прямо сейчас ведущему нужно разбить всех коллег на две команды так, чтобы каждые два человека в одной команде хорошо знали друг друга — и это непростая задача.

 Вам дан граф, в котором каждому человеку сопоставлена ровно одна вершина. Ребро (u, v) означает, что коллега u хорошо знает коллегу v (и в то же время коллега v хорошо знает коллегу u). Проверьте, можно ли разбить вершины графа на два множества требуемым образом, и, если это возможно, выведите любое подходящее разбиение.

 Формат ввода
 В первой строке даны два целых числа n и m (2 ≤ n ≤ 5000, 0 ≤ m ≤ 200000) — число вершин и число рёбер в графе.

 В следующих m строках даны описания рёбер — пары целых чисел a b (1 ≤ a, b ≤ n, a ≠ b), означающих наличие ребра между вершинами a и b.

 Гарантируется, что каждая пара вершин соединена не более чем одним ребром, и что никакая вершина не соединена с собой.

 Формат вывода
 Если разбить вершины требуемым образом нельзя, выведите -1.

 Иначе в первой строке выведите число k (1 ≤ k < n) — количество вершин в одной из частей разбиения.

 В следующей строке выведите k чисел — вершины из этой части разбиения.

 В следующей строке выведите n — k чисел — вершины из второй части разбиения.

 Каждая вершина должна принадлежать ровно одной из этих частей.
 Пример 1
 Ввод
 3 1
 1 2
 Вывод
 2
 1 2
 3
 Пример 1
 Ввод
 3 0
 Вывод
 -1
 */


var teams = Set<Set<Int>>()

func findMembers(_ matrix: inout [[Int]],_ command: Set<Int>) {

    var newCommand = command

    for people in 1...matrix.count {
        command.forEach { (member) in
            if matrix[people - 1][member - 1] == 1 {
                newCommand.insert(people)
                if newCommand != command {
                    findMembers(&matrix, newCommand)
                }
            }
        }
    }

    teams.insert(newCommand)
}

func teamBuilding(_ graph: (Int, Int),_ edges: [(Int, Int)]?) {

    guard let edges = edges else {
        if graph.0 == 2 {
            print("1")
            print("[1]")
            print("[2]")
            return
        }
        print("-1")
        return
    }


    if graph.0 < 2 || graph.0 > 5000 { return }
    if graph.1 < 0 || graph.1 > 200000 { return }
    if graph.1 != edges.count { return }

    edges.forEach { (firstValue, secondValue) in
        if firstValue < 1 || firstValue > graph.0 { return }
        if secondValue < 1 || secondValue > graph.0 { return }
    }

    var adjacencyMatrix = Array(repeating: Array(repeating: 0, count: graph.0), count: graph.0)

    for edge in edges {
        adjacencyMatrix[edge.0 - 1][edge.1 - 1] = 1
        adjacencyMatrix[edge.1 - 1][edge.0 - 1] = 1
    }

//    adjacencyMatrix.forEach { (line) in
//        print(line)
//    }

    for lider in 1...graph.0 {
        let team: Set<Int> = [lider]
        findMembers(&adjacencyMatrix, team)
    }

    var check = false
    var allMembersSet = Set<Int>()
    for member in 1...graph.0 {
        allMembersSet.insert(member)
    }

    teams.forEach { (firstTeam) in
        if check { return }
        teams.forEach { (secondTeam) in
            if check { return }
            if firstTeam.union(secondTeam) == allMembersSet {
                check = true
                print(firstTeam.count)
                print(firstTeam)
                print(secondTeam)
            }
        }
    }
    if !check { print("-1") }
}




teamBuilding((3, 1), [(1, 2)])
print()
teamBuilding((3, 0), nil)

