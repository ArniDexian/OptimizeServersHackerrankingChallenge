struct SolutionTests {
    struct TestCase {
        let requests: [String]
        let limitePerSecond: Int
        let expected: [Int]?
    }

    private init() {}

    static func run() {
        // Example usage:
        let set1 = TestCase(
            requests: [
                "1 172.253.115.138 50000",
                "2 172.253.115.139 50100",
                "3 172.253.115.138 50210",
                "4 172.253.115.139 50300",
                "5 172.253.115.138 51000",
                "6 172.253.115.139 60300"
            ],
            limitePerSecond: 1,
            expected: [3, 4]
        )

        let set2 = TestCase(
            requests: [
                "10 172.253.115.138 50000",
                "20 172.253.115.138 50000",
                "30 172.253.115.138 50000"
            ],
            limitePerSecond: 2,
            expected: [30]
        )

        let set3 = TestCase(
            requests: [
                "1 172.253.115.138 50000",
                "2 172.253.115.138 50900",
                "3 172.253.115.138 51000",
                "4 172.253.115.138 51500"
            ],
            limitePerSecond: 2,
            expected: [4]
        )

        // Custom cases
        let set4 = TestCase(
            requests: [
                "1 172.253.115.138 50000",
                "2 172.253.115.138 50900",
                "3 172.253.115.138 51000",
                "4 172.253.115.138 51500",
                "5 172.253.115.138 51500",
                "6 172.253.115.138 51500",
            ],
            limitePerSecond: 2,
            expected: [4, 5, 6]
        )

        let set5 = TestCase(
            requests: [
                "1 172.253.115.138 50000",
                "2 172.253.115.138 50900",
                "3 172.253.115.138 51000",
                "4 172.253.115.138 51500",
                "5 172.253.115.138 51500",
                "6 172.253.115.138 51500",
            ],
            limitePerSecond: 3,
            expected: [5, 6]
        )

        let set6 = TestCase(
            requests: [
                "1 172.253.115.138 50000",
                "2 172.253.115.138 50900",
                "3 172.253.115.138 51000",
                "4 172.253.115.138 51500",
                "5 172.253.115.138 51900",
            ],
            limitePerSecond: 2,
            expected: [4]
        )

        let set7 = TestCase(
            requests: [
                "1 172.253.115.138 50000",
                "2 172.253.115.138 50900",
                "3 172.253.115.138 51000",
                "4 172.253.115.138 51500",
                "5 172.253.115.138 51900",
                "6 172.253.115.138 51905",
                "7 172.253.115.138 51910",
            ],
            limitePerSecond: 2,
            expected: [4, 6, 7]
        )

        [set1, set2, set3, set4, set5, set6, set7].enumerated().forEach { (i, dataset) in
            let result = getRejectedRequests(requests: dataset.requests, limitPerSecond: dataset.limitePerSecond)
            if result == dataset.expected {
                print("Case \(i) SUCCESS")
            } else {
                print("Case \(i) FAILED, expected: \(dataset.expected!) but got \(result)")
            }
        }
    }
}
