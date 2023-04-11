//
//  NoteItem+CoreDataProperties.swift
//  Note it Do it
//
//  Created by Александр Х on 09.04.2023.
//
//

import Foundation
import CoreData


extension NoteItem {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<NoteItem> {
        return NSFetchRequest<NoteItem>(entityName: "NoteItem")
    }

    @NSManaged public var name: String?
    @NSManaged public var createData: Date?
    @NSManaged public var title: String?

}

extension NoteItem : Identifiable {

}
