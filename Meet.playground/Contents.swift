/*
 Чтобы не мешать коллегам на рабочем месте громкими обсуждениями, ребята назначают встречи на определенное время и бронируют переговорки. При бронировании нужно указать дату и время встречи, её длительность и список участников. Если у кого-то из участников получается две встречи в один и тот же момент времени, то в бронировании будет отказано с указанием списка людей, у которых время встречи пересекается с другими встречами. Вам необходимо реализовать прототип такой системы.

 Формат ввода
 В первой строке входного файла содержится одно число n (1 ≤ n ≤ 1000) — число запросов.

 В следующих n строках содержатся запросы по одному в строке. Запросы бывают двух типов:

 APPOINT day time duration k names1 names2… namesk
 PRINT day name
 day — номер дня в 2018 году (1 ≤ day ≤ 365)

 time — время встречи, строка в формате HH:MM (08 ≤ HH ≤ 21, 00 ≤ MM ≤ 59)

 duration — длительность встречи в минутах (15 ≤ duration ≤ 120)

 k — число участников встречи (1 ≤ k ≤ 10)

 namesi, name — имена участников, строки, состоящие из маленьких латинских букв (1 ≤ |name| ≤ 20). У всех коллег уникальные имена. Кроме того гарантируется, что среди участников одной встречи ни одно имя не встречается дважды.

 Формат вывода
 Если удалось назначить встречу (первый тип запросов), выведите OK.

 Иначе выведите в первой строке FAIL, а в следующей строке через пробел список имен участников, для которых время встречи пересекается с другими встречами, в том порядке, в котором имена были даны в запросе.

 Для второго типа запросов выведите для данного дня и участника список всех событий на данный момент в этот день в хронологическом порядке, по одному в строке, в формате

 HH:MM duration names1 names2 … namesk

 где имена участников следуют в том же порядке, что и в исходном описании встречи. Если событий в данный день для этого человека нет, то ничего выводить не нужно.

 Пример 1.
 Ввод
 7
 APPOINT 1 12:30 30 2 andrey alex
 APPOINT 1 12:00 30 2 alex sergey
 APPOINT 1 12:59 60 2 alex andrey
 PRINT 1 alex
 PRINT 1 andrey
 PRINT 1 sergey
 PRINT 2 alex
 Вывод
 OK
 OK
 FAIL
 alex andrey
 12:00 30 alex sergey
 12:30 30 andrey alex
 12:30 30 andrey alex
 12:00 30 alex sergey
 
 */

struct Meet {
    let day: Int
    let startTime: (Int, Int)
    let duration: Int

    var timeInterval: (Int, Int) {
        get {
            let first = startTime.0 * 60 + startTime.1
            let second = first + duration
            return (first, second)
        }
    }
    var employees: [String]
}

struct People {
    let name: String
    var meets: [Meet]

    mutating func sortMeets() {
        self.meets.sort { first, second in
            if first.day == second.day {
                if first.startTime.0 == second.startTime.0 {
                    return first.startTime.1 < second.startTime.1
                }
                return first.startTime.0 < second.startTime.0
            }
            return first.day < second.day
        }
    }
}

var companyMeets = [Meet]()
var companyEmployees = [People(name: "steve", meets: []), People(name: "bill", meets: []), People(name: "larry", meets: [])]
//var totalPrintMeets = [String]()


func request(_ title: String,_ day: Int,_ startTime: (Int, Int)?,_ duration: Int?,_ peoples: [String]) {
    if title == "APPOINT" {
        guard let startTime = startTime, let duration = duration else { return }

        if day < 1 || day > 365 { return }
        if startTime.0 < 8 || startTime.0 > 21 { return }
        if startTime.1 < 0 || startTime.1 > 59 { return }
        if duration < 15 || duration > 120 { return }
        if peoples.isEmpty || peoples.count > 10 { return }

        var checkNames = true

        for employee in peoples {
            if employee.count < 1 || employee.count > 20 { checkNames = false }
            if employee != employee.lowercased() { checkNames = false }
        }
        if !checkNames { return }

        var problemEmployees: String = ""

        let first = startTime.0 * 60 + startTime.1
        let second = first + duration
        let meetTimeInterval = (first, second)

        companyEmployees.forEach { (employee) in
            for people in peoples {
                if employee.name == people {
                    employee.meets.forEach { (meet) in
                        if meet.day != day { return }
                        if meet.timeInterval.0 < meetTimeInterval.0 {
                            if meet.timeInterval.1 > meetTimeInterval.0 {
                                problemEmployees.append(employee.name)
                                problemEmployees.append(" ")
                                return
                            }
                        }
                        if meet.timeInterval.0 < meetTimeInterval.1 {
                            if meet.timeInterval.1 > meetTimeInterval.1 {
                                problemEmployees.append(employee.name)
                                problemEmployees.append(" ")
                                return
                            }
                        }
                        if meet.timeInterval.0 > meetTimeInterval.0 {
                            if meet.timeInterval.1 < meetTimeInterval.1 {
                                problemEmployees.append(employee.name)
                                problemEmployees.append(" ")
                                return
                            }
                        }
                    }
                }
            }
        }

        if problemEmployees.last == " " { problemEmployees.removeLast() }
        if !problemEmployees.isEmpty {
            print("FAIL")
            print(problemEmployees)
            return
        }

        let meet = Meet(day: day, startTime: startTime, duration: duration, employees: peoples)
        companyMeets.append(meet)

        for i in 0..<companyEmployees.count {
            peoples.forEach { (name) in
                if name == companyEmployees[i].name {
                    companyEmployees[i].meets.append(meet)
                }
            }
        }
        print("OK")
    }

    if title == "PRINT" {
        if peoples.isEmpty || peoples.count > 1 { return }
        guard let people = peoples.first else { return }

        for i in 0..<companyEmployees.count {
            if people == companyEmployees[i].name {
                companyEmployees[i].sortMeets()

                for j in 0..<companyEmployees[i].meets.count {
                    if day == companyEmployees[i].meets[j].day {
                        var resultString = ""

                        var minuts = ""
                        if companyEmployees[i].meets[j].startTime.1 < 10 {
                            minuts.append(String(0))
                        }
                        minuts.append(String(companyEmployees[i].meets[j].startTime.1))

                        resultString.append("\(companyEmployees[i].meets[j].startTime.0):\(minuts) ")
                        resultString.append("\(companyEmployees[i].meets[j].duration) ")
                        companyEmployees[i].meets[j].employees.forEach { (employee) in
                            resultString.append("\(employee) ")
                        }
                        if resultString.last == " " { resultString.removeLast() }

//                        var notDuplicateCheck = true
//                        totalPrintMeets.forEach { (meetString) in
//                            if resultString == meetString {
//                                notDuplicateCheck = false
//                            }
//                        }
//                        totalPrintMeets.append(resultString)
//                        if notDuplicateCheck { print(resultString) }

                        print(resultString)
                    }
                }
            }
        }
    }
}

request("APPOINT", 1, (12, 30), 30, ["steve", "bill"])
request("APPOINT", 1, (12, 00), 30, ["bill", "larry"])
request("APPOINT", 1, (12, 59), 60, ["bill", "steve"])
request("PRINT", 1, nil, nil, ["bill"])
request("PRINT", 1, nil, nil, ["steve"])
request("PRINT", 1, nil, nil, ["larry"])
request("PRINT", 2, nil, nil, ["bill"])
