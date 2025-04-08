//
//  InMemoryRepository.swift
//  BookShelf
//
//  Created by Елизавета Кравченкова on 07.04.2025.
//

import Foundation

struct InMemoryBookRepository : Repository{
    
    public typealias Element = BookRepresentation
        
    var array: [UUID:any Element] = [:]
    
    public mutating func add(element: any Element) -> Result<Void, Error> {
        
        if (array[element.id] != nil){
            return 
                .failure(BookShelfError.bookAlreasyExists("bookAlreasyExists"))
        }
        
        array[element.id] = element;
        return .success(())
    }
    
    mutating func modify(element: any Element) -> Result<Void, Error> {
        
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
    
    func get() -> Result<[any Element], Error> {
        return .success(Array(array.values))
    }
    
    func getById(by id: UUID) -> Result<any Element, Error> {
        
        guard let element = array[id] else {
            return .failure(BookShelfError.bookNotExists("bookNotExists"))
        }
        
        return .success(element)
    }
    
}
