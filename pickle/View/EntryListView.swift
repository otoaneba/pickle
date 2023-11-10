//
//  EntryListView.swift
//  pickle
//
//  Created by Naoto Abe on 11/12/23.
//

import SwiftUI

struct EntryListView: View {
    var body: some View {
        NavigationStack {
            List {
                Text("Hello, World!")
                Text("Hello, World!")
                Text("Hello, World!")
            }
            .navigationTitle("Selected Date")
        }
    }
}

#Preview {
    EntryListView()
}
