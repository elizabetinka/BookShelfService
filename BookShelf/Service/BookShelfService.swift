//
//  Service.swift
//  BookShelf
//
//  Created by Елизавета Кравченкова on 07.04.2025.
//

import Foundation

protocol BookShelfService{
    
    mutating func add(request: AddBookRequest) -> AddBookResponce
    
    mutating func delete(request: DeleteBookRequest) -> DeleteBookResponce
    
    func get(request: GetBookRequest) -> GetBookResponce
    

    func filter(request: FilterBookRequest) ->FilterBookResponce
}
