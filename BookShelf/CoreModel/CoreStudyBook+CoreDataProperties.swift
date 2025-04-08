//
//  CoreStudyBook+CoreDataProperties.swift
//  BookShelf
//
//  Created by Елизавета Кравченкова on 08.04.2025.
//
//

import Foundation
import CoreData


extension CoreStudyBook {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CoreStudyBook> {
        return NSFetchRequest<CoreStudyBook>(entityName: "CoreStudyBook")
    }

    @NSManaged public var courseNumber: Int16

}
