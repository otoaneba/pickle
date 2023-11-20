//
//  DailyEntry+CoreDataProperties.swift
//
//
//  Created by Naoto Abe on 11/20/23.
//
//  This file was automatically generated and should not be edited.
//

import Foundation
import CoreData
import UIKit

@objc(DailyEntry)
class DailyEntry: NSManagedObject {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<DailyEntry> {
        return NSFetchRequest<DailyEntry>(entityName: "DailyEntry")
    }

    @NSManaged public var date: Date?
    @NSManaged public var image: UIImage?
    @NSManaged public var notes: String?

}

extension DailyEntry : Identifiable {

}
