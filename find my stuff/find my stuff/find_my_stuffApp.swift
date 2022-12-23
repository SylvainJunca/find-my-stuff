//
//  find_my_stuffApp.swift
//  find my stuff
//
//  Created by Sylvain Junca on 2022-12-22.
//

import SwiftUI

@main
struct find_my_stuffApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
