//
//  EntryItem.swift
//  pickle
//
//  Created by Naoto Abe on 11/12/23.
//

import SwiftUI

struct EntryItem {
    var id: UUID
    var title: String
    var date: Date
    var status: String
    var duration: Duration
    var location: String
    var comment: String
    var entryType: String
    var imageUrl: URL
    
    init(id: UUID, title: String, date: Date, status: String, duration: Duration, location: String, comment: String, entryType: String, imageUrl: URL) {
        self.id = id
        self.title = title
        self.date = date
        self.status = status
        self.duration = duration
        self.location = location
        self.comment = comment
        self.entryType = entryType
        self.imageUrl = imageUrl
    }

    public func getImageUrl() -> URL {
        return self.imageUrl
    }
}
