struct CircularArrayTests {
    struct TestCase {
        let array: CircularArray<Int>
        let expected: [Int]?

        init(arrayCount: Int, inputArray: [Int], expected: [Int]) {
            var array = CircularArray<Int>(count: arrayCount)
            inputArray.forEach { array.push($0) }
            self.array = array
            self.expected = expected
        }
    }

    private init() {}

    static func run() {
        let testCases = [
            TestCase(arrayCount: 1, inputArray: [], expected: []),
            TestCase(arrayCount: 1, inputArray: [1], expected: [1]),
            TestCase(arrayCount: 1, inputArray: [1, 2], expected: [2]),
            TestCase(arrayCount: 1, inputArray: [1, 2, 3], expected: [3]),
            TestCase(arrayCount: 1, inputArray: [1, 2, 3, 4], expected: [4]),
            TestCase(arrayCount: 2, inputArray: [], expected: []),
            TestCase(arrayCount: 2, inputArray: [1], expected: [1]),
            TestCase(arrayCount: 2, inputArray: [1, 2], expected: [1, 2]),
            TestCase(arrayCount: 2, inputArray: [1, 2, 3], expected: [2, 3]),
            TestCase(arrayCount: 2, inputArray: [1, 2, 3, 4], expected: [3, 4]),
            TestCase(arrayCount: 2, inputArray: [1, 2, 3, 4, 5], expected: [4, 5]),
            TestCase(arrayCount: 3, inputArray: [], expected: []),
            TestCase(arrayCount: 3, inputArray: [1], expected: [1]),
            TestCase(arrayCount: 3, inputArray: [1, 2], expected: [1, 2]),
            TestCase(arrayCount: 3, inputArray: [1, 2, 3], expected: [1, 2, 3]),
            TestCase(arrayCount: 3, inputArray: [1, 2, 3, 4], expected: [2, 3, 4]),
            TestCase(arrayCount: 3, inputArray: [1, 2, 3, 4, 5], expected: [3, 4, 5]),
            TestCase(arrayCount: 4, inputArray: [], expected: []),
            TestCase(arrayCount: 4, inputArray: [1, 2, 3], expected: [1, 2, 3]),
            TestCase(arrayCount: 4, inputArray: [1, 2, 3, 4], expected: [1, 2, 3, 4]),
            TestCase(arrayCount: 4, inputArray: [1, 2, 3, 4, 5, 6, 7, 8, 9, 10], expected: [7, 8, 9, 10]),
        ]

        testCases.enumerated().forEach { (i, testSet) in
            let result = testSet.array.toArray()
            if result == testSet.expected {
                print("Circular array case \(i) SUCCESS")
            } else {
                print("Circular array case \(i) FAILED, expected: \(testSet.expected!) but got \(result)")
            }
        }
    }
}

private extension CircularArray {
    func toArray() -> [Element] {
        reduce([]) { partialResult, element in
            partialResult + [element]
        }
    }
}
