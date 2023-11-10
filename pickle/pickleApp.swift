//
//  pickleApp.swift
//  pickle
//
//  Created by Naoto Abe on 11/10/23.
//

import SwiftUI

@main
struct pickleApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
