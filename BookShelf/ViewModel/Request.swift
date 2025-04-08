//
//  Request.swift
//  BookShelf
//
//  Created by Елизавета Кравченкова on 07.04.2025.
//

import Foundation


struct AddBookRequest{
    let book: BookRepresentation
}

struct DeleteBookRequest{
    let id: UUID
}

struct GetBookRequest{
    
}


enum TypeBook{
    case simple
    case comic
    case study
}

struct FilterBookRequest{
    let id: UUID?
    let title: String?
    let author: String?
    let publicationYear: UInt64?
    let genre: Genre?
    let type: TypeBook?
    let courseNumber: UInt64?
    let publicationNumber: UInt64?
}

