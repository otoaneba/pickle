//
//  EntryListView.swift
//  pickle
//
//  Created by Naoto Abe on 11/12/23.
//

import SwiftUI

struct EntryListView: View {
    let entryItem: EntryItem = EntryItem(id: UUID(), title: "Trip to Japan", date: .now, status: "status", duration: .seconds(5), location: "Tokyo, Japan", comment: "Today was fun", entryType: "video")
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
