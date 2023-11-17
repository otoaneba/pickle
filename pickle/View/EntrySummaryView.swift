//
//  EntrySummaryView.swift
//  pickle
//
//  Created by Naoto Abe on 11/13/23.
//

import SwiftUI

struct EntrySummaryView: View {
    var entry: EntryItem
    let vm: EntrySummaryViewModel = EntrySummaryViewModel()

    var body: some View {
        VStack {
            VideoCardView(url: entry.getImageUrl())
                .padding()
            List {
                Section {
 
                    LabeledContent("Date", value: "\(entry.date.formatted(date: .numeric, time: .omitted))")
                    LabeledContent("Location", value: "\(entry.location)")
                    Section {
                        Text("\(entry.comment)")
                    } header: {
                        Text("Notes")
                    }
  
                }
            }.listStyle(.inset)
    
        }
    }
}

#Preview {
    EntrySummaryView(entry: EntryItem(id: UUID(), title: "Trip to Japan", date: .now, status: "status", duration: .seconds(59), location: "Kyoyo, Japan", comment: "The instance’s content represents a read-only or read-write value, and its label identifies or describes the purpose of that value. The resulting element has a layout that’s consistent with other framework controls and automatically adapts to its container, like a form or toolbar. Some styles of labeled content also apply styling or behaviors to the value content, like making Text views selectable.", entryType: "video", imageUrl: URL(string: "file:///var/mobile/Containers/Data/Application/57971C6D-889D-4CB7-ADFD-90E3BB6420CA/Documents/test.jpg")!))
}
