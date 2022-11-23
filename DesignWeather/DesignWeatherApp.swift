//
//  DesignWeatherApp.swift
//  DesignWeather
//
//  Created by Michal Gruszkiewicz on 23/11/2022.
//

import SwiftUI

@main
struct DesignWeatherApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
