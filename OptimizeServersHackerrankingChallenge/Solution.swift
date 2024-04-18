func getRejectedRequests(requests: [String], limitPerSecond: Int) -> [Int] {
    var counter = RequestCounter(limitPerSecond: limitPerSecond)

    return requests.reduce(into: []) { partialResult, requestString in
        let comps = requestString.split(separator: " ")
        guard let id = Int(comps[0]), let ts = Int64(comps[2]) else { return }
        let ip = String(comps[1])
        if !counter.doAcceptRequest(from: ip, at: ts) {
            partialResult.append(id)
        }
    }
}
