/*
 Коля очень любит читать, и он ходил бы в библиотеку каждый день. К вечеру он остаётся довольным, только если прочитал ровно на одну книгу больше, чем вчера. Однако, к сожалению, библиотека не работает по субботам и воскресеньям. Поэтому Коля ходит в неё каждый рабочий день и берёт там за раз k книг — больше нельзя по правилам. Однако, Колю радует, что брать новые k книг можно, даже если ты не отдал какие-то книги из взятых ранее. Также Колю радует, что в его домашней библиотеке есть запас из m книг.

 Вам известно, какой сегодня день недели. Коля недавно встал и задался целью прочитать сегодня ровно одну книгу. Насколько долго Коля может оставаться довольным, если будет ходить в библиотеку каждый раз, когда это возможно, начиная с сегодняшнего дня? Можно считать, что запас книг в библиотеке бесконечен.

 Формат ввода
 В первой строке входного файла даны три целых числа k, m, d — лимит на количество книг, которые можно взять в библиотеке в день, количество книг дома у Коли и сегодняшний день недели (1 ≤ k ≤ 109, 0 ≤ m ≤ 109, 1 ≤ d ≤ 7). Суббота и воскресенье обозначаются числами 6 и 7.

 Формат вывода
 Выведите одно число — максимальное количество дней в периоде, в течение которого Коля каждый день сможет читать столько книг, чтобы оставаться довольным.
 Пример 1.
 Ввод
 4 2 5
 Вывод
 4
 Пример 2.
 Ввод
 4 3 5
 Вывод
 5

 */

func calculatingHappiness(_ limit: Int,_ reserve: Int,_ day: Int) {

    if limit < 1 || limit > 109 { return }
    if reserve < 0 || reserve > 109 { return }
    if day < 1 || day > 7 { return }

    var day = day
    var dayCount = 0
    var reserve = reserve
    var readBooks = 1
    var happy = true

    while happy {
        if day > 7 {
            day = day % 7
        }

        switch day {
        case 1...5:
            reserve += limit - readBooks
        case 6, 7:
            reserve -= readBooks
        default:
            break
        }

        if reserve >= 0 {
            dayCount += 1
            day += 1
            readBooks += 1
        } else {
            happy = false
        }
    }
    print(dayCount)
}

calculatingHappiness(4, 2, 5)
calculatingHappiness(4, 3, 5)
