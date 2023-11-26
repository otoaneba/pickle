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
    @State private var notes = ""
    @State private var saveButtonPressed: Bool = false

    var body: some View {
        NavigationStack {
            VStack {
                VideoCardView(url: entry.getImageUrl())
                    .padding()
                        LabeledContent("Date", value: "\(entry.date.formatted(date: .numeric, time: .omitted))")
                        LabeledContent("Location", value: "\(entry.location)")
                        Label("Notes", systemImage: "list.clipboard.fill")
                        TextEditor(text: $notes)
                            .frame(height: 350)
                            .cornerRadius(10)
                            .border(.white)
                NavigationLink("Save 2") {
                    ContentView()
                }.simultaneousGesture(TapGesture().onEnded {
                    print("save information here")
                    
                }).foregroundColor(.white)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.blue)
                    .cornerRadius(10)
                Spacer()
            }

        }

    }
}

#Preview {
    EntrySummaryView(entry: EntryItem(id: UUID(), title: "Trip to Japan", date: .now, status: "status", duration: .seconds(59), location: "Kyoyo, Japan", comment: "The instance’s content represents a read-only or read-write value, and its label identifies or describes the purpose of that value. The resulting element has a layout that’s consistent with other framework controls and automatically adapts to its container, like a form or toolbar. Some styles of labeled content also apply styling or behaviors to the value content, like making Text views selectable.", entryType: "video", imageUrl: URL(string: "file:///var/mobile/Containers/Data/Application/57971C6D-889D-4CB7-ADFD-90E3BB6420CA/Documents/test.jpg")!))
}
