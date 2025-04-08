//
//  CoreBookRepresentation+CoreDataClass.swift
//  BookShelf
//
//  Created by Елизавета Кравченкова on 08.04.2025.
//
//

import Foundation
import CoreData

@objc(CoreBookRepresentation)
public class CoreBookRepresentation: NSManagedObject {

    var publicationYear : UInt64?
    {
        get { return publication_year == -1 ? nil : UInt64(publication_year)}
        set { 
            if let unwrapped = newValue { publication_year = Int32(unwrapped)}
            else { publication_year = -1}
        }
    }
    
    var genre: Genre
    {
        get { return Genre(rawValue: genre_int) ?? Genre.fiction }
        set { genre_int = newValue.rawValue }
    }
    
    public override func awakeFromInsert() {
            super.awakeFromInsert()
            self.publication_year = -1
        }
}
