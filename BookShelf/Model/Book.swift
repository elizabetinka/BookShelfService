//
//  Bool.swift
//  BookShelf
//
//  Created by Елизавета Кравченкова on 07.04.2025.
//

import Foundation

struct Book : BookRepresentation {
    var id = UUID()
    var title: String
    var author: String
    var publicationYear: UInt64?
    var genre: Genre
}
