//
//  Response.swift
//  BookShelf
//
//  Created by Елизавета Кравченкова on 07.04.2025.
//

import Foundation

protocol Responce {
    var status: Bool {get}
    var error: Error? {get}
}

struct AddBookResponce :  Responce {
    let status: Bool
    let error: Error?
}

struct DeleteBookResponce :  Responce {
    let status: Bool
    let error: Error?
}

struct GetBookResponce :  Responce {
    let status: Bool
    let error: Error?
    let books: [BookDto]
}

struct FilterBookResponce :  Responce {
    let status: Bool
    let error: Error?
    let books: [BookDto]
}



