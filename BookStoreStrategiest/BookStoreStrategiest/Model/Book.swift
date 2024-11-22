//
//  Book.swift
//  BookStoreStrategiest
//
//  Created by Kunal Kumar R on 20/11/24.
//

import Foundation

struct Book: Identifiable, Equatable {
    let id: UUID
    let title: String
    let author: Author
    let category: BookCategory
    let price: Double
    let inventoryCount: Int
    
    static func == (lhs: Book, rhs: Book) -> Bool {
        lhs.id == rhs.id
    }
    
    static var example = Book(id: UUID(), title: "Harry Potter and the Sorcerer's Stone", author: Author.examples[0], category: .fiction, price: 19.99, inventoryCount: 100)
    
    static var examples = [
        Book(id: UUID(), title: "Harry Potter and the Sorcerer's Stone", author: Author.examples[0], category: .fiction, price: 19.99, inventoryCount: 100),
        Book(id: UUID(), title: "The Lord of the Rings: The Fellowship of the Ring", author: Author.examples[1], category: .fantasy, price: 24.99, inventoryCount: 80),
        Book(id: UUID(), title: "Pride and Prejudice", author: Author.examples[2], category: .business, price: 12.99, inventoryCount: 60),
        Book(id: UUID(), title: "To Kill a Mockingbird", author: Author.examples[3], category: .fiction, price: 14.99, inventoryCount: 70),
        Book(id: UUID(), title: "The Hitchhiker's Guide to the Galaxy", author: Author.examples[4], category: .children, price: 16.99, inventoryCount: 50),
        Book(id: UUID(), title: "The Great Gatsby", author: Author.examples[5], category: .business, price: 11.99, inventoryCount: 40),
        Book(id: UUID(), title: "The Catcher in the Rye", author: Author.examples[6], category: .fiction, price: 13.99, inventoryCount: 30),
        Book(id: UUID(), title: "1984", author: Author.examples[7], category: .fantasy, price: 15.99, inventoryCount: 20),
        Book(id: UUID(), title: "The Silmarillion", author: Author.examples[8], category: .fantasy, price: 22.99, inventoryCount: 10),
        Book(id: UUID(), title: "The Hobbit", author: Author.examples[3], category: .fantasy, price: 18.99, inventoryCount: 90),
        Book(id: UUID(), title: "The Lion, the Witch, and the Wardrobe", author: Author.examples[2], category: .fantasy, price: 17.99, inventoryCount: 80),
        Book(id: UUID(), title: "The Little Prince", author: Author.examples[0], category: .fiction, price: 9.99, inventoryCount: 70),
        Book(id: UUID(), title: "The Alchemist", author: Author.examples[8], category: .fiction, price: 10.99, inventoryCount: 60),
        Book(id: UUID(), title: "The Girl with the Dragon Tattoo", author: Author.examples[1], category: .children, price: 14.99, inventoryCount: 50),
        Book(id: UUID(), title: "The Da Vinci Code", author: Author.examples[9], category: .business, price: 16.99, inventoryCount: 40),
        Book(id: UUID(), title: "Gone Girl", author: Author.examples[5], category: .biography, price: 15.99, inventoryCount: 30),
        Book(id: UUID(), title: "The Shining", author: Author.examples[6], category: .computerScience, price: 13.99, inventoryCount: 20),
        Book(id: UUID(), title: "It", author: Author.examples[7], category: .biography, price: 15.99, inventoryCount: 10),
        Book(id: UUID(), title: "The Handmaid's Tale", author: Author.examples[8], category: .computerScience, price: 14.99, inventoryCount: 90),
        Book(id: UUID(), title: "Brave New World", author: Author.examples[3], category: .computerScience, price: 13.99, inventoryCount: 80)
    ]
}
