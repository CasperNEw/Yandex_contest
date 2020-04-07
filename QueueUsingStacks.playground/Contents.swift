struct Stack<T> {

    private var array = [T]()

    func isEmpty() -> Bool {
        return array.isEmpty
    }

    mutating func push(_ value: T) {
        array.append(value)
    }

    mutating func pop() -> T? {
        return isEmpty() ? nil : array.removeLast()
    }

    func size() -> Int {
        return array.count
    }
}

struct Queue<T> {

    private var stackOne = Stack<T>()
    private var stackTwo = Stack<T>()

    func isEmpty() -> Bool {
        return stackOne.isEmpty() && stackTwo.isEmpty()
    }

    mutating func push(_ value: T) {
        stackOne.push(value)
    }

    mutating func pop() -> T? {
        if !stackTwo.isEmpty() {
            return stackTwo.pop()
        } else {
            while !stackOne.isEmpty() {
                stackTwo.push(stackOne.pop()!)
            }
            return stackTwo.pop()
        }
    }

    func size() -> Int {
        return stackOne.size() + stackTwo.size()
    }
}

var testQueue = Queue<Int>()

testQueue.push(1)
testQueue.push(2)
testQueue.push(3)
print(testQueue.pop() as Any)
testQueue.push(4)
testQueue.push(5)
testQueue.push(6)
print(testQueue.pop() as Any)
testQueue.push(7)
testQueue.push(8)
testQueue.push(9)
print(testQueue.pop() as Any)
testQueue.push(10)
print(testQueue.pop() as Any)
print(testQueue)
print(testQueue.size())

