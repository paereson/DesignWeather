//
//  ContentView.swift
//  DesignWeather
//
//  Created by Michal Gruszkiewicz on 23/11/2022.
//

import SwiftUI
import CoreData

struct ContentView: View {
    var body: some View {
        HomeView()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
