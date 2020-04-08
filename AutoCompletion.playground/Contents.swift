/*
 Аркадий реализовал интерактивную систему автодополнения, которая должна позволить ему быстрее набирать тексты университетских работ, в том числе и дипломной.

 Система запоминает все слова, которые уже есть в тексте. Если Аркадий набирает очередное слово, введенная непустая часть которого совпадает с префиксом ровно одного из уже введенных слов, то после нажатия специальной комбинации клавиш введенную часть можно мгновенно дополнить имеющимся словом.

 Например, Аркадий уже ввел слова дипломная работа и автодополнение в различных системах. Рассмотрим несколько вариантов очередного слова, которое ему нужно ввести:

 диплом — после ввода первого символа система предложит принять автодополнение дипломная, но оно не подходит;
 работа — после ввода первого и второго символа система не будет ничего предлагать, т.к. есть два различных слова в тексте, которые начинаются с текущего префикса, но после ввода третьего символа останется только одно слово (предложенное автодополнение следует принять);
 различие — вновь вариант с автодополнением появится только после ввода третьего символа, но в этот раз принимать предложенный вариант не следует.

 У Аркадия не работает клавиша удаления введенных символов, поэтому удалять символы из текста он не может.

 Аркадий также решил, что не будет использовать автодополнение, если предлагаемое слово является началом набираемого, но не совпадает с ним целиком.

 Помогите Аркадию определить, сколько раз он воспользуется функцией автодополнения, если хочет максимально уменьшить количество нажатий на клавиши клавиатуры, соответствующие буквенным символам.

 Формат ввода
 В первой строке входных данных записано одно целое число n (1 ≤ n ≤ 100 000) — количество слов, которые собирается набрать Аркадий. Во второй строке записаны n слов si (1 ≤ |si| ≤ 1000). Все слова в строке состоят только из строчных букв английского алфавита и разделены одиночными пробелами.

 Суммарная длина всех слов не превосходит 1 000 000 символов.

 Формат вывода
 В единственной строке выведите одно целое число: количество нажатий буквенных клавиш на клавиатуре.
 Пример 1
 Ввод
 3
 hello world hello
 Вывод
 11
 Пример 2
 Ввод
 5
 an apple a big apple
 Вывод
 13
 Пример 3
 Ввод
 5
 aaaaa aaaab aaaaa abaaa abaaa
 Вывод
 22

 */

func autoCompletionTest(_ wordCount: Int,_ text: String) {
    if wordCount < 1 || wordCount > 100000 { return }
    if text.isEmpty || text.count > 1000000 { return }
    
    var text = text
    var dictinary = [String]()
    var word: String = ""
    var totalCount = 0

    text.append(" ")
    text.forEach { (character) in
        if character != " " {
            word.append(character)
        }
        if character == " " {
            if word != "" {
                dictinary.append(word)
            }
            word = ""
        }
    }

    if wordCount != dictinary.count { return }

    for index in 0..<dictinary.count {

        var chars = [Character]()
        dictinary[index].forEach { (char) in
            chars.append(char)
        }
        var prefix: String = ""
        prefix.append(chars[0])
        var k = 0
        var wordsWithPrefix = 0

        while wordsWithPrefix != 1 && prefix != dictinary[index] {

            wordsWithPrefix = 0
            var testIndex = 0

            for i in 0..<index {
                if dictinary[i].hasPrefix(prefix) {
                    wordsWithPrefix += 1
                    testIndex = i
                }
            }
            if wordsWithPrefix == 1 {
                if dictinary[index] != dictinary[testIndex] {
                    wordsWithPrefix = 0
                }
            }

            k += 1
            if prefix != dictinary[index] {
                if wordsWithPrefix != 1 {
                    prefix.append(chars[k])
                }
            }
//            print(wordsWithPrefix, prefix, dictinary[index])
        }

        if prefix == dictinary[index] || wordsWithPrefix == 1 {
            totalCount += prefix.count
        }
    }

    print(totalCount)

}

autoCompletionTest(3, "hello world hello")
autoCompletionTest(5, "an apple a bit apple")
autoCompletionTest(5, "aaaaa aaaab aaaaa abaaa abaaa")
