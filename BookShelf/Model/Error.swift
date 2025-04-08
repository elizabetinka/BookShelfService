//
//  Error.swift
//  BookShelf
//
//  Created by Елизавета Кравченкова on 07.04.2025.
//

import Foundation

enum BookShelfError : Error {
    case bookNotExists(String)
    case bookAlreasyExists(String)
    case emptyData(String)
    case enumInvalidParse(String)
    
}
