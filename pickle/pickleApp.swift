//
//  pickleApp.swift
//  pickle
//
//  Created by Naoto Abe on 11/10/23.
//

import SwiftUI

@main
struct pickleApp: App {
    @Environment(\.scenePhase) var scenePhase
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
//            let entry = EntryItem(id: UUID(), title: "Trip to Japan", date: .now, status: "status", duration: .seconds(59), location: "Kyoyo, Japan", comment: "The instance’s content represents a read-only or read-write value, and its label identifies or describes the purpose of that value. The resulting element has a layout that’s consistent with other framework controls and automatically adapts to its container, like a form or toolbar. Some styles of labeled content also apply styling or behaviors to the value content, like making Text views selectable.", entryType: "video", imageUrl: URL(string: "file:///var/mobile/Containers/Data/Application/57971C6D-889D-4CB7-ADFD-90E3BB6420CA/Documents/test.jpg")!)
//            EntrySummaryView(entry:entry)
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
        .onChange(of: scenePhase) {
            persistenceController.save()
        }
    }
}
