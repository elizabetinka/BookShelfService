//
//  CoreBookRepresentation+CoreDataProperties.swift
//  BookShelf
//
//  Created by Елизавета Кравченкова on 08.04.2025.
//
//

import Foundation
import CoreData


extension CoreBookRepresentation {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CoreBookRepresentation> {
        return NSFetchRequest<CoreBookRepresentation>(entityName: "CoreBookRepresentation")
    }

    @NSManaged public var id: UUID
    @NSManaged public var title: String?
    @NSManaged public var author: String?
    @NSManaged public var publication_year: Int32
    @NSManaged public var genre_int: Int16

}

extension CoreBookRepresentation : Identifiable {

}
