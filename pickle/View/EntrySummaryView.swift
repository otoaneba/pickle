//
//  EntrySummaryView.swift
//  pickle
//
//  Created by Naoto Abe on 11/13/23.
//

import SwiftUI

struct EntrySummaryView: View {
    @Environment(\.colorScheme) var colorScheme
    @State private var notes = ""
    @State private var saveButtonPressed: Bool = false
    @FocusState var isInputActive: Bool
    var entry: EntryItem
    let vm: EntrySummaryViewModel = EntrySummaryViewModel()

    var body: some View {
        NavigationStack {
            Form {
                VStack(alignment: .leading) {
                    VideoCardView(url: entry.getImageUrl())
                        .padding()
                    LabeledContent("Date", value: "\(entry.date.formatted(date: .numeric, time: .omitted))")
                    LabeledContent("Location", value: "\(entry.location)")
                    Label("Notes", systemImage: "list.clipboard.fill")
                        .padding(.top)
                    TextEditor(text: $notes)
                        .focused($isInputActive)
                        .toolbar {
                            //ToolbarItem(placement: .keyboard) {
                            if isInputActive {
                                Button("Done") {
                                    isInputActive = false
                                }
                            }
                           // }
                        }
                        .frame(height: 350)
                        .cornerRadius(5) /// make the background rounded
                        .overlay( /// apply a rounded border
                            RoundedRectangle(cornerRadius: 5)
                                .stroke(colorScheme == .dark ? .white : .gray, lineWidth: 1)
                        )
                    NavigationLink("Save") {
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
//            .padding(.horizontal)
        }

    }
}

#Preview {
    EntrySummaryView(entry: EntryItem(id: UUID(), title: "Trip to Japan", date: .now, status: "status", duration: .seconds(59), location: "Kyoyo, Japan", comment: "The instance’s content represents a read-only or read-write value, and its label identifies or describes the purpose of that value. The resulting element has a layout that’s consistent with other framework controls and automatically adapts to its container, like a form or toolbar. Some styles of labeled content also apply styling or behaviors to the value content, like making Text views selectable.", entryType: "video", imageUrl: URL(string: "file:///var/mobile/Containers/Data/Application/57971C6D-889D-4CB7-ADFD-90E3BB6420CA/Documents/test.jpg")!))
}
