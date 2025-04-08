//
//  CoreBook+CoreDataProperties.swift
//  BookShelf
//
//  Created by Елизавета Кравченкова on 08.04.2025.
//
//

import Foundation
import CoreData


extension CoreBook {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CoreBook> {
        return NSFetchRequest<CoreBook>(entityName: "CoreBook")
    }


}
