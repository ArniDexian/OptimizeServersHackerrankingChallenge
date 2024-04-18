//
//  CircularArray.swift
//  GoodnotesChallenge
//
//  Created by Arni Dexian on 18/04/2024.
//

import Foundation

struct CircularArray<Element>: Sequence {
    typealias Element = Element

    private var data: [Element]
    private let maxCount: Int
    private var firstIndex: Int
    private var lastIndex: Int

    init(count: Int) {
        precondition(count > 0, "Can't create circular array with size 0")
        self.data = []
        self.maxCount = count
        self.firstIndex = 0
        self.lastIndex = 0
    }

    mutating func push(_ element: Element) {
        guard data.count == maxCount else {
            lastIndex += 1
            data.append(element)
            return
        }

        lastIndex = lastIndex + 1 >= maxCount ? 0 : lastIndex + 1
        firstIndex = firstIndex + 1 >= maxCount ? 0 : firstIndex + 1

        data[lastIndex] = element
    }


    func makeIterator() -> Iterator {
        Iterator(array: self)
    }
}

// MARK: - Iterator for circular array

extension CircularArray {
    internal struct Iterator: IteratorProtocol {
        private var currentIndex: Int
        private let array: CircularArray
        init(array: CircularArray) {
            self.array = array
            self.currentIndex = 0
        }

        mutating func next() -> Element? {
            guard currentIndex < array.data.count else { return nil }
            defer {
                currentIndex += 1
            }
            var index = array.firstIndex + currentIndex
            if index >= array.maxCount {
                index %= array.maxCount
            }
            return array.data[index]
        }
    }
}
