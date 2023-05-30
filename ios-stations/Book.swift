//
//  Book.swift
//  ios-stations
//

struct Book: Decodable {
    let id: String
    let title: String
    let url: String
    let detail: String
    let review: String
    let reviewer: String
}

struct BooksResponse: Decodable {
    var books: [Book]
    
    init(from decoder: Decoder) throws {
        var container = try decoder.unkeyedContainer()
        self.books = []
        while !container.isAtEnd {
            let book = try container.decode(Book.self)
            books.append(book)
        }
    }
}
