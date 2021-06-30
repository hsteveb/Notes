//
//  NotesApp.swift
//  Notes
//
//  Created by Hector Barrios on 12/22/20.
//

import SwiftUI

@main
struct NotesApp: App {
    let persistenceController = PersistenceController.shared
    let listener = SwiftUIResponderListener()

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
                .environmentObject(listener)
        }
    }
}
