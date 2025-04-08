//
//  BookShelfServiceImpl.swift
//  BookShelf
//
//  Created by Елизавета Кравченкова on 07.04.2025.
//

import Foundation

struct BookShelfServiceImpl<T:Repository> : BookShelfService where T.Element == BookRepresentation {
    
    var bookRepostory : T
    
    init(repository: T) {
            self.bookRepostory = repository
        }
    
    mutating func add(request: AddBookRequest) -> AddBookResponce {
        
        if (request.book.title.isEmpty || request.book.author.isEmpty){
            return .init(status: false, error: BookShelfError.emptyData("empty title or author"))
        }
        
        switch bookRepostory.add(element: toModel(dto: request.book)) {
            
        case .failure(let error):
                return .init(status: false, error: error)
        case .success():
            return .init(status: true, error: nil)
        }
    }
    
    mutating func delete(request: DeleteBookRequest) -> DeleteBookResponce {
        switch bookRepostory.delete(by: request.id) {
            
        case .failure(let error):
                return .init(status: false, error: error)
        case .success():
            return .init(status: true, error: nil)
        }
    }
    
    func get(request: GetBookRequest) -> GetBookResponce {
        switch bookRepostory.get() {
            
        case .failure(let error):
                return .init(status: false, error: error, books: [])
        case .success(let books):
            return .init(status: true, error: nil, books: books.map { fromModel(model: $0)})
        }
    }
    
    func filter(request: FilterBookRequest) -> FilterBookResponce {
        switch bookRepostory.get() {
            
        case .failure(let error):
                return .init(status: false, error: error, books: [])
            
        case .success(var books):
            let books_dto =  books.map { fromModel(model: $0)}
            return .init(status: true, error: nil, books: filter(request: request, books: books_dto))
        }
    }
    
    private func filter(request: FilterBookRequest, books: [BookDto]) -> [BookDto]{
        
        var ans: [BookDto] = books
        
        if let id = request.id{
            ans=ans.filter { $0.id == id }
        }
        if let author = request.author {
            ans=ans.filter { $0.author == author }
        }
        if let title = request.title {
            ans=ans.filter { $0.title == title }
        }
        if let genre = request.genre{
            ans=ans.filter { $0.genre == genre}
        }
        if let publicationYear = request.publicationYear {
            ans=ans.filter { $0.publicationYear == publicationYear}
        }
        if let type = request.type{
            switch type{
            case TypeBook.simple:
                ans=ans.filter { $0 is Book}
            case TypeBook.comic:
                ans=ans.filter { $0 is ComicBook}
            case TypeBook.study:
                ans=ans.filter { $0 is StudyBook}
            }
        }
        if let courseNumber = request.courseNumber {
            ans=ans.filter { 
                if let studyBook = $0 as? StudyBook{
                    return studyBook.courseNumber==courseNumber
                }
                else {
                    return false;
                }}
        }
        
        if let publicationNumber = request.publicationNumber {
            ans=ans.filter {
                if let studyBook = $0 as? ComicBook{
                    return studyBook.publicationNumber==publicationNumber
                }
                else {
                    return false;
                }}
        }
        return ans
        
    }
    
    
}
