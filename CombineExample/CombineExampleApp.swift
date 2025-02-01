//
//  CombineExampleApp.swift
//  CombineExample
//
//  Created by haram on 2/1/25.
//

import SwiftUI

@main
struct CombineExampleApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
