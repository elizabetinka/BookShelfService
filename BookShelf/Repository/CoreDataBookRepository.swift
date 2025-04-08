//
//  CoreDataBookRepository.swift
//  BookShelf
//
//  Created by Елизавета Кравченкова on 08.04.2025.
//

import Foundation
import CoreData

struct CoreDataBookRepository : Repository{
    
    public typealias Element = BookRepresentation
    
    var dataManager = DataManager.shared
    
    mutating func add(element: Element) -> Result<Void, Error> {
        toCoreModel(model: element)
        return dataManager.saveContext()
    }
    
    mutating func delete(by id: UUID) -> Result<Void, Error> {
        let fetchRequest: NSFetchRequest<CoreBookRepresentation> = CoreBookRepresentation.fetchRequest()

        fetchRequest.predicate = NSPredicate(format: "id == %@", id as CVarArg)

        do {
            let results = try dataManager.viewContext.fetch(fetchRequest)
            
            for book in results{
                dataManager.viewContext.delete(book)
            }
            
            return dataManager.saveContext()
        
        } catch {
            return .failure(error)
        }
    }
    
    func get() -> Result<[Element], Error> {
        let fetchRequest: NSFetchRequest<CoreBookRepresentation> = CoreBookRepresentation.fetchRequest()

        do {
            let results = try dataManager.viewContext.fetch(fetchRequest)
            return .success(results.map { fromCoreModel(model: $0)})
        
        } catch {
            return .failure(error)
        }
    }
    
    func getById(by id: UUID) -> Result<Element?, Error> {
        let fetchRequest: NSFetchRequest<CoreBookRepresentation> = CoreBookRepresentation.fetchRequest()

        fetchRequest.predicate = NSPredicate(format: "id == %@", id as CVarArg)

        do {
            let results = try dataManager.viewContext.fetch(fetchRequest)
            
            if let unwrapped = results.first {
                return .success(fromCoreModel(model:unwrapped))
            }
            return .success(nil)
        
        } catch {
            return .failure(error)
        }
    }
    
    mutating func modify(element: Element) -> Result<Void, Error> {
        let fetchRequest: NSFetchRequest<CoreBookRepresentation> = CoreBookRepresentation.fetchRequest()

        fetchRequest.predicate = NSPredicate(format: "id == %@", element.id as CVarArg)

        do {
            let results = try dataManager.viewContext.fetch(fetchRequest)
            
            if var unwrapped = results.first {
                unwrapped = toCoreModel(model: element)
                return dataManager.saveContext()
            }
            
            return .failure(BookShelfError.bookNotExists("Book is not exist"))
        
        } catch {
            return .failure(error)
        }
    }
    
    private mutating func toCoreModel(model: BookRepresentation) -> CoreBookRepresentation {
        let book : CoreBookRepresentation
        if let comicBook = model as? ComicBook {
            let entity = NSEntityDescription.entity(forEntityName: "CoreComicBook", in: dataManager.viewContext)!
            book = CoreComicBook(entity: entity, insertInto: dataManager.viewContext)
            let typed_book = book as! CoreComicBook
            typed_book.publicationNumber = Int64(comicBook.publicationNumber)
            typed_book.id = comicBook.id
            typed_book.title = comicBook.title
            typed_book.author = comicBook.author
            typed_book.genre = comicBook.genre
            typed_book.publicationYear = comicBook.publicationYear
            return typed_book
        }
        else if let studyBook = model as? StudyBook {
            let entity = NSEntityDescription.entity(forEntityName: "CoreStudyBook", in: dataManager.viewContext)!
            book = CoreStudyBook(entity: entity, insertInto: dataManager.viewContext)
            let typed_book = book as! CoreStudyBook
            typed_book.courseNumber = Int16(studyBook.courseNumber)
            typed_book.id = studyBook.id
            typed_book.title = studyBook.title
            typed_book.author = studyBook.author
            typed_book.genre = studyBook.genre
            typed_book.publicationYear = studyBook.publicationYear
            return typed_book
        }
        else {
            let entity = NSEntityDescription.entity(forEntityName: "CoreBook", in: dataManager.viewContext)!
            book = CoreBook(entity: entity, insertInto: dataManager.viewContext)
            book.id = model.id
            book.title = model.title
            book.author = model.author
            book.genre = model.genre
            book.publicationYear = model.publicationYear
            return book
        }
        
//        book.id = model.id
//        book.title = model.title
//        book.author = model.author
//        book.genre = model.genre
//        book.publicationYear = model.publicationYear
//        return book
    }
    
    private func fromCoreModel(model: CoreBookRepresentation) -> BookRepresentation{
        var book : BookRepresentation
        if let comicBook = model as? CoreComicBook {
            book = ComicBook(title: comicBook.title ?? "", author: comicBook.author ?? "", genre: comicBook.genre, publicationNumber: UInt64(comicBook.publicationNumber))
        }
        else if let studyBook = model as? CoreStudyBook{
            book = StudyBook(title: studyBook.title ?? "", author: studyBook.author ?? "", genre: studyBook.genre, courseNumber: UInt64(studyBook.courseNumber))
        }
        else {
            book = Book(title: model.title ?? "", author: model.author ?? "" , genre: model.genre)
        }
        book.publicationYear = model.publicationYear
        book.id = model.id
        return book
    }
}
