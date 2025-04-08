//
//  DtoModels.swift
//  BookShelf
//
//  Created by Елизавета Кравченкова on 07.04.2025.
//

import Foundation


protocol BookDto {
    var id: UUID {get}
    var title: String { get}
    var author: String { get }
    var publicationYear: UInt64? { get}
    var genre: Genre {get}
}

struct SimpleBookDto : BookDto {
    let id: UUID
    let title: String
    let author: String
    let publicationYear: UInt64?
    let genre: Genre
}

struct ComicBookDto : BookDto {
    let id: UUID
    let title: String
    let author: String
    let publicationYear: UInt64?
    let genre: Genre
    let publicationNumber: UInt64
}

struct StudyBookDto : BookDto {
    let id: UUID
    let title: String
    let author: String
    let publicationYear: UInt64?
    let genre: Genre
    let courseNumber: UInt64
}
