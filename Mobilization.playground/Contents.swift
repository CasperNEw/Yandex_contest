/*
 В Яндексе снова стартует проект «Мобилизация»! Компания набирает на трёхмесячную подготовку n молодых людей, увлечённых мобильной разработкой. В начале проекта был проведён тест, где скилл участника i в разработке был оценен как ai, а скилл в управлении как bi.

 На время проекта участников необходимо разделить на две равные по количеству участников команды — разработчиков и менеджеров. Планируется сделать это таким образом, чтобы максимизировать суммарную пользу, приносимую всеми участниками. Если участнику достанется роль разработчика, его польза будет равняться ai, в противном случае — bi.

 Но даже занятые проектом, участники находят время для получения новых знаний! Иногда участники приносят сертификаты о прохождении курсов, где сказано, что скилл участника i в разработке или же в управлении увеличился на di. В таком случае может быть выгодно переформировать команды для максимизации суммарной пользы (равные размеры команд необходимо сохранить).

 Ваша задача помочь Яндексу и после рассмотрения каждого нового принесённого участником сертификата посчитать текущую суммарную пользу команд.

 Формат ввода
 В первой строке входного файла дано число n (2 ≤ n ≤ 2 ⋅ 105, n — чётное) — количество участников проекта. Вторая строка задаёт n целых чисел ai (0 ≤ ai ≤ 109) — скилл каждого из участников в разработке. Следующая строка в том же формате задаёт скилл участников в управлении bi (0 ≤ bi ≤ 109).

 Следующая строка содержит целое число m (1 ≤ m ≤ 105) — количество принесённых участниками сертификатов. Каждая из следующих m строк содержит три целых числа numi, typei, di (1 ≤ numi ≤ n, 1 ≤ typei ≤ 2, 1 ≤ di ≤ 104) — номер участника, тип увеличиваемого скилла (1 — разработка, 2 — управление) и значение увеличения соответствующего навыка.

 Формат вывода
 После обработки каждого запроса на поступление нового сертификата выведите текущую суммарную пользу всех участников.
 Пример 1.
 Ввод
 4
 7 15 3 4
 10 10 0 6
 3
 1 1 4
 4 1 6
 2 2 10
 Вывод
 34
 35
 43

 */

struct Student: Hashable {
    let number: Int
    let devSkill: Int
    let manageSkill: Int
}

var count: Int = 0
var dev: [Int] = []
var manage: [Int] = []


// MARK: First - bad decision

func setupMobilization(_ studentCount: Int,_ devSkills: [Int],_ manageSkills: [Int]) -> Int {

    count = studentCount
    dev = devSkills
    manage = manageSkills

    if studentCount < 2 || studentCount > 2 * 105 || studentCount % 2 != 0 { return -1 }
    if devSkills.count < 0 || devSkills.count > 109 { return -1 }
    if manageSkills.count < 0 || manageSkills.count > 109 { return -1 }

    var students = Set<Student>()
    for index in 0..<studentCount {
        students.insert(Student(number: index + 1, devSkill: devSkills[index], manageSkill: manageSkills[index]))
    }

    var totalSkills = 0
    var devTeam = Set<Student>()
    students.sorted { (studentOne, studentTwo) -> Bool in
        return studentOne.devSkill > studentTwo.devSkill
    }.forEach { (student) in
        if devTeam.count != studentCount / 2 {
            devTeam.insert(student)
            totalSkills += student.devSkill
        }
    }

    let otherTeam = students.subtracting(devTeam)
    otherTeam.forEach { (student) in
        totalSkills += student.manageSkill
    }

    var anotherTotalSkills = 0
    let manageTeam = Set<Student>()
    students.sorted { (studentOne, studentTwo) -> Bool in
        return studentOne.manageSkill > studentTwo.manageSkill
    }.forEach { (student) in
        if devTeam.count != studentCount / 2 {
            devTeam.insert(student)
            anotherTotalSkills += student.manageSkill
        }
    }

    let anotherOtherTeam = students.subtracting(manageTeam)
    anotherOtherTeam.forEach { (student) in
        anotherTotalSkills += student.devSkill
    }

    return totalSkills > anotherTotalSkills ? totalSkills : anotherTotalSkills
}

func addSert(_ sertCount: Int,_ serts: [(Int, Int, Int)]) {
    if sertCount < 1 || sertCount > 105 { return }
    serts.forEach { (numi, typei, di) in
        if numi < 1 || numi > count { return }
        if typei < 1 || typei > 2 { return }
        if di < 1 || di > 104 { return }
    }
    if sertCount != serts.count { return }

    serts.forEach { (numi, typei, di) in
        switch typei {
        case 1:
            dev[numi - 1] += di
        case 2:
            manage[numi - 1] += di
        default:
            break
        }

        print(setupMobilization(count, dev, manage))
    }
}

//setupMobilization(4, [7, 15, 3, 4], [10, 10, 0, 6])
//addSert(3, [(1, 1, 4), (4, 1, 6), (2, 2, 10)])

// --------------------------------------------------

// MARK: Second - expensive decision

var skills = Set<Int>()

func findMembers(_ students: inout Set<Student>,_ command: Set<Student>) {

    var newCommand = command

    students.forEach { (student) in

        if newCommand.count < students.count / 2 {
            if !newCommand.contains(student) {
                newCommand.insert(student)
                findMembers(&students, newCommand)
            }
        } else {
            var totalSkills = 0
            var anotherTotalSkills = 0
            newCommand.forEach { (student) in
                totalSkills += student.devSkill
                anotherTotalSkills += student.manageSkill
            }
            let otherTeam = students.subtracting(newCommand)
            otherTeam.forEach { (student) in
                totalSkills += student.manageSkill
                anotherTotalSkills += student.devSkill
            }
            skills.insert(totalSkills)
            skills.insert(anotherTotalSkills)
        }
    }
}

func setupAgain(_ studentCount: Int,_ devSkills: [Int],_ manageSkills: [Int]) {

    count = studentCount
    dev = devSkills
    manage = manageSkills

    if studentCount < 2 || studentCount > 2 * 105 || studentCount % 2 != 0 { return }
    if devSkills.count < 0 || devSkills.count > 109 { return }
    if manageSkills.count < 0 || manageSkills.count > 109 { return }

    var students = Set<Student>()
    for index in 0..<studentCount {
        students.insert(Student(number: index + 1, devSkill: devSkills[index], manageSkill: manageSkills[index]))
    }

    students.forEach { (student) in
        var team = Set<Student>()
        team.insert(student)
        findMembers(&students, team)
    }
}

func againAddSert(_ sertCount: Int,_ serts: [(Int, Int, Int)]) {
    if sertCount < 1 || sertCount > 105 { return }
    serts.forEach { (numi, typei, di) in
        if numi < 1 || numi > count { return }
        if typei < 1 || typei > 2 { return }
        if di < 1 || di > 104 { return }
    }
    if sertCount != serts.count { return }

    serts.forEach { (numi, typei, di) in
        switch typei {
        case 1:
            dev[numi - 1] += di
        case 2:
            manage[numi - 1] += di
        default:
            break
        }

        setupAgain(count, dev, manage)
        print(skills.max() as Any)
        print(skills)
    }
}


//setupAgain(4, [7, 15, 3, 4], [10, 10, 0, 6])
//againAddSert(3, [(1, 1, 4), (4, 1, 6), (2, 2, 10)])

// --------------------------------------------------

// MARK: Are you kidding me?! Third try ...

func addSertThird(_ sertCount: Int,_ serts: [(Int, Int, Int)]) {
    if sertCount < 1 || sertCount > 105 { return }
    serts.forEach { (numi, typei, di) in
        if numi < 1 || numi > count { return }
        if typei < 1 || typei > 2 { return }
        if di < 1 || di > 104 { return }
    }
    if sertCount != serts.count { return }

    serts.forEach { (numi, typei, di) in
        switch typei {
        case 1:
            dev[numi - 1] += di
        case 2:
            manage[numi - 1] += di
        default:
            break
        }

        if let total = setupThird(count, dev, manage) {
            print(total)
        }
    }
}

func setupThird(_ studentCount: Int,_ devSkills: [Int],_ manageSkills: [Int]) -> Int? {

    count = studentCount
    dev = devSkills
    manage = manageSkills

    if studentCount < 2 || studentCount > 2 * 105 || studentCount % 2 != 0 { return nil }
    if devSkills.count < 0 || devSkills.count > 109 { return nil }
    if manageSkills.count < 0 || manageSkills.count > 109 { return nil }

    var students = Set<Student>()
    for index in 0..<studentCount {
        students.insert(Student(number: index + 1, devSkill: devSkills[index], manageSkill: manageSkills[index]))
    }

    var devTeam = Set<Student>()
    var manageTeam = Set<Student>()

    students.sorted { (studentOne, studentTwo) -> Bool in
        var firstDi = 0
        var secondDi = 0

        if studentOne.devSkill > studentOne.manageSkill {
            firstDi = studentOne.devSkill - studentOne.manageSkill
        } else {
            firstDi = studentOne.manageSkill - studentOne.devSkill
        }

        if studentTwo.devSkill > studentTwo.manageSkill {
            secondDi = studentTwo.devSkill - studentTwo.manageSkill
        } else {
            secondDi = studentTwo.manageSkill - studentTwo.devSkill
        }
        return firstDi > secondDi
    }.forEach { (student) in
        if devTeam.count != students.count / 2 {
            if manageTeam.count != students.count / 2 {
                student.devSkill >= student.manageSkill ? devTeam.insert(student) : manageTeam.insert(student)
            } else {
                devTeam = devTeam.union(students.subtracting(manageTeam))
            }
        } else {
            manageTeam = manageTeam.union(students.subtracting(devTeam))
        }
    }

    var totalSkills = 0

    devTeam.forEach { (student) in
        totalSkills += student.devSkill
    }
    manageTeam.forEach { (student) in
        totalSkills += student.manageSkill
    }

    return totalSkills
}


setupThird(4, [7, 15, 3, 4], [10, 10, 0, 6])
addSertThird(3, [(1, 1, 4), (4, 1, 6), (2, 2, 10)])
