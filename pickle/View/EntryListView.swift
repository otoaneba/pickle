//
//  EntryListView.swift
//  pickle
//
//  Created by Naoto Abe on 11/12/23.
//

import SwiftUI

struct EntryListView: View {
    let entryItem: EntryItem = EntryItem(id: UUID(), title: "Trip to Japan", date: .now, status: "status", duration: .seconds(5), location: "Tokyo, Japan", comment: "Today was fun", entryType: "video", imageUrl: URL(string: "file:///var/mobile/Containers/Data/Application/57971C6D-889D-4CB7-ADFD-90E3BB6420CA/Documents/test.jpg")!)
    var body: some View {
        NavigationStack {
            List {
                EntryRowItem(entryItem: entryItem)
            }
            .navigationTitle("Selected Date")
        }
    }
}

#Preview {
    EntryListView()
}
