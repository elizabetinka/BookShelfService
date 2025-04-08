//
//  DtoModels.swift
//  BookShelf
//
//  Created by Елизавета Кравченкова on 07.04.2025.
//

import Foundation


func toModel (dto: BookDto) -> BookRepresentation {
    var book : BookRepresentation
    
    if let comicBook = dto as? ComicBookDto {
        book = ComicBook(title: comicBook.title, author: comicBook.author, genre: comicBook.genre, publicationNumber: comicBook.publicationNumber)
    }
    else if let studyBook = dto as? StudyBookDto {
        book = StudyBook(title: studyBook.title, author: studyBook.author, genre: studyBook.genre, courseNumber: studyBook.courseNumber)
    }
    else {
        book = Book(title: dto.title, author: dto.author, genre: dto.genre)
    }
    book.publicationYear = dto.publicationYear
    return book
}

func fromModel (model: BookRepresentation) -> BookDto {
    if let comicBook = model as? ComicBook {
        return ComicBookDto(id: comicBook.id, title: comicBook.title, author: comicBook.author, publicationYear: comicBook.publicationYear, genre: comicBook.genre, publicationNumber: comicBook.publicationNumber)
    }
    else if let studyBook = model as? StudyBook {
        return StudyBookDto(id: studyBook.id, title: studyBook.title, author: studyBook.author, publicationYear: studyBook.publicationYear, genre: studyBook.genre, courseNumber: studyBook.courseNumber)
    }
    else{
        return SimpleBookDto(id: model.id, title: model.title, author: model.author, publicationYear: model.publicationYear, genre: model.genre)
    }
}


protocol BookDto {
    var id: UUID? {get}
    var title: String { get}
    var author: String { get }
    var publicationYear: UInt64? { get}
    var genre: Genre {get}
}

struct SimpleBookDto : BookDto {
    let id: UUID?
    let title: String
    let author: String
    let publicationYear: UInt64?
    let genre: Genre
}

struct ComicBookDto : BookDto {
    let id: UUID?
    let title: String
    let author: String
    let publicationYear: UInt64?
    let genre: Genre
    let publicationNumber: UInt64
}

struct StudyBookDto : BookDto {
    let id: UUID?
    let title: String
    let author: String
    let publicationYear: UInt64?
    let genre: Genre
    let courseNumber: UInt64
}
