//
//  Entry.swift
//  pickle
//
//  Created by Naoto Abe on 11/20/23.
//

import Foundation
import CoreData
import UIKit

@objc(Entry)
class Entry: NSManagedObject {
    
    @nonobjc public class override func fetchRequest() -> NSFetchRequest<Entry> {
        return NSFetchRequest(entityName: "Entry"))
    }
    
    @NSManaged public var image: UIImage?
    @NSManaged public var date: Date?
    @NSManaged public var note: String?
    
}

extension Entry: Identifiable {
    
}
