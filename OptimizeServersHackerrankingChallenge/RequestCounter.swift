// This objects tracks max N requests per IP adress for last 1 second
struct RequestCounter {
    class Item {
        private var lastTimestamps: CircularArray<Int64>
        init(firstTs: Int64, maxCount: Int) {
            self.lastTimestamps = .init(count: maxCount)
            lastTimestamps.push(firstTs)
        }
        func track(ts: Int64) {
            self.lastTimestamps.push(ts)
        }
        func lastSecondCallsCount(from fromTs: Int64) -> Int {
            var counter = 0
            for ts in lastTimestamps.reversed() {
                if fromTs - ts < 1000 { // 1000ms
                    counter += 1
                } else {
                    break
                }
            }
            return counter
        }
    }
    private let limitPerSecond: Int
    private var ipRequestTsMap = [String: Item]()

    init(limitPerSecond: Int) {
        self.limitPerSecond = limitPerSecond
    }
    
    /// Check if the request can be accepted
    /// - Returns: true if requests can be accepted, false if request must be rejected
    mutating func doAcceptRequest(from ip: String, at ts: Int64) -> Bool {
        guard let history = ipRequestTsMap[ip] else {
            ipRequestTsMap[ip] = Item(firstTs: ts, maxCount: limitPerSecond)
            return true
        }

        // get how much requests were send during the last second
        if history.lastSecondCallsCount(from: ts) < limitPerSecond {
            // track only accepted requests
            history.track(ts: ts)
            return true
        } else {
            return false
        }
    }
}
