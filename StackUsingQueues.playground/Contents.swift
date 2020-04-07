//Stack using Array
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
//Queue using Stacks
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

//Stack using Queues
struct ExcessStack<T> {

    private var queueOne = Queue<T>()
    private var queueTwo = Queue<T>()

    func isEmpty() -> Bool {
        return queueOne.isEmpty() && queueTwo.isEmpty()
    }

    mutating func push(_ value: T) {
        queueOne.isEmpty() ? pushLogic(&queueOne, &queueTwo, value) : pushLogic(&queueTwo, &queueOne, value)
    }

    mutating func pop() -> T? {
        return !queueOne.isEmpty() ? queueOne.pop() : queueTwo.pop()
    }

    func size() -> Int {
        return queueOne.size() + queueTwo.size()
    }

    private func pushLogic(_ emptyQueue: inout Queue<T>, _ otherQueue: inout Queue<T>, _ value: T) {
        emptyQueue.push(value)
        while !otherQueue.isEmpty() {
            emptyQueue.push(otherQueue.pop()!)
        }
    }
}

extension ExcessStack {
    //complementary implementation when pop operation costly
    private mutating func anotherPush(_ value: T) {
        queueOne.isEmpty() ? queueOne.push(value) : queueTwo.push(value)
    }

    private mutating func anotherPop() -> T? {
        return queueOne.isEmpty() ? anotherPopLogic(&queueOne, &queueTwo) : anotherPopLogic(&queueTwo, &queueOne)
    }

    private func anotherPopLogic(_ emptyQueue: inout Queue<T>, _ otherQueue: inout Queue<T>) -> T? {
        while otherQueue.size() > 1 {
            emptyQueue.push(otherQueue.pop()!)
        }
        return otherQueue.pop()
    }
}
