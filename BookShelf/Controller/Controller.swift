//
//  Controller.swift
//  BookShelf
//
//  Created by Елизавета Кравченкова on 08.04.2025.
//

import Foundation

protocol Controller {
    func filterBook()
    mutating func deleteBook()
    func getBook()
    mutating func addBook()
}
