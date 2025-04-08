//
//  InMemoryRepository.swift
//  BookShelf
//
//  Created by Елизавета Кравченкова on 07.04.2025.
//

import Foundation

struct InMemoryBookRepository : Repository {

    public typealias Element = BookRepresentation
        
    var array: [UUID:Element] = [:]
    
    public mutating func add(element: Element) -> Result<Void, Error> {
        
        if (array[element.id] != nil){
            return 
                .failure(BookShelfError.bookAlreasyExists("bookAlreasyExists"))
        }
        
        array[element.id] = element;
        return .success(())
    }
    
    mutating func modify(element: Element) -> Result<Void, Error> {
        
        if (array[element.id] == nil){
            return .failure(BookShelfError.bookNotExists("bookNotExists"))
        }
        
        array[element.id] = element;
        return .success(())
    }
    
    mutating func delete(by id: UUID) -> Result<Void, Error> {
        
        if (array[id] == nil){
            return .failure(BookShelfError.bookNotExists("bookNotExists"))
        }
        
        array.removeValue(forKey: id)
        return .success(())
    }
    
    func get() -> Result<[Element], Error> {
        return .success(Array(array.values))
    }
    
    func getById(by id: UUID) -> Result<Element?, Error> {
        
        guard let element = array[id] else {
            return .success(nil)
        }
        
        return .success(element)
    }
    
}
