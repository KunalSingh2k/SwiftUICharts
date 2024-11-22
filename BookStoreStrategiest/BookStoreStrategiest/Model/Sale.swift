//
//  Sale.swift
//  BookStoreStrategiest
//
//  Created by Kunal Kumar R on 20/11/24.
//

import Foundation

struct Sale: Identifiable, Equatable {
    let id: UUID
    let book: Book
    let quantity: Int
    let saleDate: Date
    
    static var example = Sale(id: UUID(), book: Book.examples[0], quantity: 5, saleDate: Date(timeIntervalSinceNow: -7_200_000))
    
    static var examples = [
            Sale(id: UUID(), book: Book.examples[0], quantity: 5, saleDate: Date(timeIntervalSinceNow: -7_200_000)),
            Sale(id: UUID(), book: Book.examples[1], quantity: 3, saleDate: Date(timeIntervalSinceNow:
         -12_960_000)),
            Sale(id: UUID(), book: Book.examples[2], quantity: 2, saleDate: Date(timeIntervalSinceNow: -18_144_000)),
            Sale(id: UUID(), book: Book.examples[3], quantity: 4, saleDate: Date(timeIntervalSinceNow: -23_328_000)),
            Sale(id: UUID(), book: Book.examples[4], quantity: 6, saleDate: Date(timeIntervalSinceNow: -28_512_000)),
            Sale(id: UUID(), book: Book.examples[5], quantity: 1, saleDate: Date(timeIntervalSinceNow: -33_696_000)),
            Sale(id: UUID(), book: Book.examples[6], quantity: 7, saleDate: Date(timeIntervalSinceNow: -38_880_000)),
            Sale(id: UUID(), book: Book.examples[7], quantity: 5, saleDate: Date(timeIntervalSinceNow: -44_064_000)),
            Sale(id: UUID(), book: Book.examples[8], quantity: 2, saleDate: Date(timeIntervalSinceNow: -49_248_000)),
            Sale(id: UUID(), book: Book.examples[9], quantity: 3, saleDate: Date(timeIntervalSinceNow: -54_432_000))
        ]
    
    static func threeMonthsExample() -> [Sale] {
        let threeMonthsAgo = Calendar.current.date(byAdding: .month, value: -3, to: Date())!
        
        let exampleSales: [Sale] = (1...300).map { _ in
            let randomBook = Book.examples.randomElement()!
            let randomQuantity = Int.random(in: 1...5)
            let randomDate = Date.random(in: threeMonthsAgo...Date())
            
            return Sale(id: UUID(), book: randomBook, quantity: randomQuantity, saleDate: randomDate)
        }
        return exampleSales.sorted { $0.saleDate < $1.saleDate }
    }
}


extension Date {
    static func random(in range: ClosedRange<Date>) -> Date {
        let difference = range.upperBound.timeIntervalSinceReferenceDate - range.lowerBound.timeIntervalSinceReferenceDate
        let randomValue = difference * Double.random(in: 0...1) + range.lowerBound.timeIntervalSinceReferenceDate
        return Date(timeIntervalSinceReferenceDate: randomValue)
    }
}
