//
//  BookRepresentation.swift
//  BookShelf
//
//  Created by Елизавета Кравченкова on 07.04.2025.
//

import Foundation

protocol BookRepresentation {
    var id: UUID { get}
    var title: String { get set }
    var author: String { get set }
    var publicationYear: UInt64? { get set}
    var genre: Genre {get set}
}
