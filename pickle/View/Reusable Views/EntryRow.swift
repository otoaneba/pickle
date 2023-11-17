//
//  EntryRow.swift
//  pickle
//
//  Created by Naoto Abe on 11/12/23.
//

import SwiftUI

struct EntryRowItem: View {
    let entryItem: EntryItem
    var body: some View {
        HStack {
            VStack {
                Text("\(entryItem.title)")
                Text("\(entryItem.date.formatted(date: .numeric, time: .omitted))")
            }
            Spacer()
            Image(systemName: entryItem.entryType)
            
        }
        .padding()
    }
}

#Preview {
    EntryRowItem(entryItem: EntryItem(id: UUID(), title: "Trip to China", date: Date(), status: "status", duration: .seconds(5), location: "Atlanta, GA", comment: "I am happy today", entryType: "video", imageUrl: URL(string: "file:///var/mobile/Containers/Data/Application/57971C6D-889D-4CB7-ADFD-90E3BB6420CA/Documents/test.jpg")!))
}
