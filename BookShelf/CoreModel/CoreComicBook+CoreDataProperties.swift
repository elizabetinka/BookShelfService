//
//  CoreComicBook+CoreDataProperties.swift
//  BookShelf
//
//  Created by Елизавета Кравченкова on 08.04.2025.
//
//

import Foundation
import CoreData


extension CoreComicBook {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CoreComicBook> {
        return NSFetchRequest<CoreComicBook>(entityName: "CoreComicBook")
    }

    @NSManaged public var publicationNumber: Int64

}
