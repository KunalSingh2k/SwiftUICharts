//
//  Author.swift
//  BookStoreStrategiest
//
//  Created by Kunal Kumar R on 20/11/24.
//

import Foundation

struct Author: Identifiable {
    let id = UUID()
    let name: String
    
    static var example = Author(name: "J.K Rowling")
    
    static var examples = [
        Author(name: "J.K Rowling"),
        Author(name: "George Orwell"),
        Author(name: "Franz Kafka"),
        Author(name: "Oscar Wilde"),
        Author(name: "Jane Austen"),
        Author(name: "William Shakespeare"),
        Author(name: "Lewis Carroll"),
        Author(name: "Leo Tolstoy"),
        Author(name: "Virginia Woolf"),
        Author(name: "Rabindranath Tagore"),
    ]
}
