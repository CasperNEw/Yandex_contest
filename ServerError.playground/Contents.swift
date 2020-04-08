/*
Вы обслуживаете сайт и отслеживаете возникающие проблемы. Клиент получил ошибку после того, как попытался добавить свой пост в систему. Вы хотите понять на каком из серверов эта ошибка произошла.

Есть n серверов, на i-й из них приходится ai процентов запросов, из которых bi процентов завершаются с ошибкой. Для каждого сервера найдите вероятность того, что ошибка произошла именно на нём.

Формат ввода
В первой строке входного файла содержится одно целое число n (1 ≤n≤ 100) — количество серверов.

В каждой из следующих n строк содержится два целых числа ai bi (0 ≤ ai, bi ≤ 100) — вероятность того что запрос пойдет на i-й сервер в процентах и вероятность того что на i-м сервере случится ошибка в процентах.

Гарантируется, что сумма всех ai равна 100 и ошибка в системе может произойти.

Формат вывода
Выведите n строк. В каждой строке должно находиться одно вещественное число (0 ≤ pi ≤ 1) — вероятность, что ошибка произошла на соответствующем сервере.

Абсолютная или относительная погрешность каждого из ответов не должна превышать 10-9.
*/

struct Server {

    private var requestProbability: Int = 0
    private var errorProbability: Int = 0
    var probability: Int {
        get { return requestProbability * errorProbability }
    }

    var ai: Int {
        get { return requestProbability }
        set { checkValue(newValue, value: &requestProbability) }
    }

    var bi: Int {
        get { return errorProbability }
        set { checkValue(newValue, value: &errorProbability) }
    }

    private func checkValue(_ newValue: Int, value: inout Int) {
        if newValue > 100 {
            value = 100
        } else if newValue < 0 {
            value = 0
        } else {
            value = newValue
        }
    }

    init(ai: Int, bi: Int) {
        self.ai = ai
        self.bi = bi
    }
}

var servers = [Server]()
var result = [Double]()

servers.append(Server(ai: 10, bi: 100))
servers.append(Server(ai: 30, bi: 10))
servers.append(Server(ai: 60, bi: 2))

var total: Int = 0
for i in 0...(servers.count-1) {
    total += servers[i].probability
    print(i+1, servers[i])
}

for i in 0...(servers.count-1) {
    result.append(Double(servers[i].probability) / Double(total))
    print("probability for \(i+1) - server : \(result[i])")
}
