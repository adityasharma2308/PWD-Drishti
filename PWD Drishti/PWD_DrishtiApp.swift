//
//  PWD_DrishtiApp.swift
//  PWD Drishti
//
//  Created by Aditya Sharma on 19/07/24.
//

import SwiftUI

@main
struct PWD_DrishtiApp: App {
    let persistenceController = PersistenceController.shared
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)

        }
    }
}
