//
//  BookRepository.swift
//  BookShelf
//
//  Created by Елизавета Кравченкова on 07.04.2025.
//

import Foundation

protocol Repository{
    associatedtype Element
    
    mutating func add(element: Element) -> Result<Void, Error>
    mutating func delete(by id: UUID) -> Result<Void, Error>
    func get() -> Result<[Element], Error>
    func getById(by id: UUID) -> Result<Element?, Error>
    mutating func modify(element: Element) -> Result<Void, Error>
}
